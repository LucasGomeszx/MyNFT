//
//  NftDetailViewModel.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 01/12/23.
//

import Foundation
import SwiftUI
import Combine

class NftDetailViewModel: ObservableObject {
    
    @Published var userNft: UserNftModel
    @Published var userNftState: UserNftModel
    @Published var isAlertVisible: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertErrorMessage: String = ""
    @Published var criptoModel: CriptoModel = CriptoModel(usd: [:])
    @Published var criptoImageNames: [String] = ["btc", "eth", "bnb"]
    private var cancellable: Set<AnyCancellable> = []
    
    init(userNft: UserNftModel) {
        self.userNft = userNft
        self.userNftState = userNft
    }
    
    var isDiferrent: Bool {
        userNft.nftValue == userNftState.nftValue
    }
    
    private func isValidDollarValue(_ value: String) -> Bool {
        let pattern = #"^\$?\d+(\.\d{1,2})?$"#
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: value.utf16.count)
        let matches = regex.matches(in: value, options: [], range: range)
        return !matches.isEmpty
    }
    
    public func updateUserNft() {
        if !isValidDollarValue(userNftState.nftValue) {
            alertTitle = "Erro"
            alertErrorMessage = "Digite um valor valido Ex: 10.30 ou 100"
            isAlertVisible.toggle()
        }
        else {
            userNft.nftValue = userNftState.nftValue
            FirestoreManager.shared.updateNftList(userNft: userNft) { result in
                switch result {
                case .success(_):
                    self.alertTitle = "Sucesso"
                    self.alertErrorMessage = "NFT alterado"
                    self.isAlertVisible.toggle()
                case .failure(_):
                    self.alertTitle = "Erro"
                    self.alertErrorMessage = "Nao foi possilvel alterar NFT"
                    self.isAlertVisible.toggle()
                }
            }
        }
    }
    
    public func fetchData() {
        ServiceManager.shered.getCriptoCoins { response in
            switch response {
            case .success(let success):
                self.criptoModel = success
            case .failure(let failure):
                self.alertTitle = "RequestError"
                self.alertErrorMessage = failure.localizedDescription
                self.isAlertVisible.toggle()
            }
        }
    }
    
}
