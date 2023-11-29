//
//  NftTabView.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 28/11/23.
//

import SwiftUI

struct NftTabView: View {
    
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("My NFTs", systemImage: "folder")

                }
            
            NftListView()
                .tabItem {
                    Label("NFTs List", systemImage: "list.dash")
                    
                }
        }
        .tint(.white)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NftTabView()
}
