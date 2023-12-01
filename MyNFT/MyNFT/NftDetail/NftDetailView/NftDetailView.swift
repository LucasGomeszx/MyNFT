//
//  NftDetailView.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import SwiftUI

struct NftDetailView: View {
    
    @Binding var userNft: UserNftModel
    
    var body: some View {
        Button("Delegar") {
            userNft.nftValue = "9999"
            FirestoreManager.shared.updateNftList(userNft: userNft) { result in
                switch result {
                case .success(let success):
                    break
                case .failure(let failure):
                    break
                }
            }
        }
    }
}

#Preview {
    @State var userNft: UserNftModel = UserNftModel(id: "aaaa", nftImageName: "fox", nftValue: "5000")
    
    return NftDetailView(userNft: $userNft)
}
