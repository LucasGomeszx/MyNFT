//
//  NftListViewModel.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import Foundation

class NftListViewModel: ObservableObject {
    
    @Published var nftList: [UserNftModel] = []
    
    func getUserNftList() {
        FirestoreManager.shared.getUserData { result in
            switch result {
            case .success(let success):
                self.nftList = success.nftList ?? []
            case .failure(_):
                break
            }
        }
    }
    
    func removeNft(userNft: UserNftModel) {
        FirestoreManager.shared.deleteNewNft(userNftModel: userNft) { result in
            switch result {
            case .success(_):
                self.getUserNftList()
            case .failure(_):
                break
            }
        }
    }
    
}
