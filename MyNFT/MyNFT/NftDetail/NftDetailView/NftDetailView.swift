//
//  NftDetailView.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import SwiftUI

struct NftDetailView: View {
    
    @Binding var userNft: UserNftModel
    @State var userNftState: UserNftModel
    
    init(userNft: Binding<UserNftModel>) {
        _userNft = userNft
        _userNftState = State(wrappedValue: userNft.wrappedValue)
    }
    
    var body: some View {
        ZStack {
            
            Color.backgroundColor.ignoresSafeArea()
            
            VStack {
                
                Image(userNft.nftImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 250, maxHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .overlay(RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.white, lineWidth: 2.0)  )
                    .shadow(radius: 20)
                    .padding(.top, 20)
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    Text("Valor: ")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    
                    TextField("", text: $userNftState.nftValue )
                        .padding(.leading, 10)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 150)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 8).stroke(Color.fieldBorderColor, lineWidth: 2)
                        })
                        .background(Color.buttonColor)
                    
                    Spacer()
                }
                
                Text("Seu NFT em outras moedas.")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .bold))
                
                List {
                    
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Button {
                    
                } label: {
                    Text("Atualizar")
                        .frame(width: 180, height: 45)
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .bold))
                        .background(Color.buttonColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
                
                Spacer()
            }
        }
    }
    
}

#Preview {
    @State var userNft: UserNftModel = UserNftModel(id: "aaaa", nftImageName: "fox", nftValue: "5000")
    
    return NftDetailView(userNft: $userNft)
}
