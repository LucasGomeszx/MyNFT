//
//  NftListView.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 28/11/23.
//

import SwiftUI

struct NftListView: View {
    
    @StateObject var viewModel: NftListViewModel = NftListViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                List($viewModel.nftList) { $nft in
                    NavigationLink {
                        NftDetailView(userNft: nft)
                    } label: {
                        HStack {
                            Image(nft.nftImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .overlay(RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(Color.white, lineWidth: 2.0)  )
                                .shadow(radius: 10)
                            
                            Text("Valor : $\(nft.nftValue)")
                                .foregroundStyle(.white)
                            
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel.removeNft(userNft: nft)
                                    } label: {
                                        Label("Delete", systemImage:"trash")
                                            .tint(.red)
                                    }
                                }
                        }

                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.buttonColor)
                }

            }
            .scrollContentBackground(.hidden)
        }
        .onAppear(perform: {
            viewModel.getUserNftList()
        })
    }
    
}

#Preview {
    NavigationStack {
        NftListView()
    }
}
