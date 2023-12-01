//
//  AddNftViewModel.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import Foundation
import SwiftUI

class AddNftViewModel: ObservableObject {
    
    var nftImageName: String
    @Published var value: String = ""
    @Published var isAlertVisible: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertErrorMessage: String = ""
    
    init(nftImageName: String) {
        self.nftImageName = nftImageName
    }
    
    private func isValidDollarValue(_ value: String) -> Bool {
        let pattern = #"^\$?\d+(\.\d{1,2})?$"#
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: value.utf16.count)
        let matches = regex.matches(in: value, options: [], range: range)

        return !matches.isEmpty
    }
    
    public func AddNft() {
        if !isValidDollarValue(value) {
            alertTitle = "Erro"
            alertErrorMessage = "Digite um valor valido Ex: 10.30 ou 100"
            isAlertVisible.toggle()
        }
        else {
            let myNft = UserNftModel(nftImageName: nftImageName, nftValue: value)
            FirestoreManager.shared.addNewNft(userNft: myNft) { result in
                switch result {
                case .success(_):
                    self.alertTitle = "Sucesso"
                    self.alertErrorMessage = "NFT salvo."
                    self.isAlertVisible.toggle()
                case .failure(let error):
                    self.alertTitle = "Erro"
                    self.alertErrorMessage = error.localizedDescription
                    self.isAlertVisible.toggle()
                }
            }
        }
    }
    
    
    
}
