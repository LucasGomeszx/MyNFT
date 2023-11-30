//
//  HomeView.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 28/11/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            
            Color.backgroundColor.ignoresSafeArea()
            
            VStack {
                
                titleText()
                
                homeNftList()

            }
        }
        .environmentObject(viewModel)
    }
}

struct titleText: View {
    var body: some View {
        Text("Meus NFTs")
            .foregroundStyle(.white)
            .font(.title)
    }
}

struct homeNftList: View {
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        List(viewModel.nftList) { nft in
            NavigationLink {
                Color.black
            } label: {
                Image(nft.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .overlay(RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.white, lineWidth: 2.0)  )
                    .shadow(radius: 20)
                
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.buttonColor)
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
