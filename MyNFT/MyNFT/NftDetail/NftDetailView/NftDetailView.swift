//
//  NftDetailView.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import SwiftUI

struct NftDetailView: View {
    
    @StateObject var viewModel: NftDetailViewModel
    
    init(userNft: UserNftModel) {
        _viewModel = StateObject(wrappedValue: NftDetailViewModel(userNft: userNft))
    }
    
    var body: some View {
        ZStack {
            
            Color.backgroundColor.ignoresSafeArea()
            
            VStack {
                
                Image(viewModel.userNft.nftImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 250, maxHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .overlay(RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.white, lineWidth: 2.0)  )
                    .shadow(radius: 20)
                    .padding(.top, 20)
                
                HStack(alignment: .center) {
                    
                    Text("Valor: ")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    
                    TextField("", text: $viewModel.userNftState.nftValue )
                        .keyboardType(.decimalPad)
                        .padding(.leading, 10)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 150)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 8).stroke(Color.fieldBorderColor, lineWidth: 2)
                        })
                        .background(Color.buttonColor)
                    
                }
                
                Text("Seu NFT em outras moedas.")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .bold))
                
                List {
                    Group {
                        NftDetailCell(criptoValue: $viewModel.criptoModel.usd["btc"] , nftValur: $viewModel.userNftState.nftValue, imageName: $viewModel.criptoImageNames[0])
                        NftDetailCell(criptoValue: $viewModel.criptoModel.usd["bnb"] , nftValur: $viewModel.userNftState.nftValue, imageName: $viewModel.criptoImageNames[1])
                        NftDetailCell(criptoValue: $viewModel.criptoModel.usd["eth"] , nftValur: $viewModel.userNftState.nftValue, imageName: $viewModel.criptoImageNames[2])
                    }
                    .frame(height: 100)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.buttonColor)

                }
                .scrollContentBackground(.hidden)
    
                Spacer()
                
                Button {
                    viewModel.updateUserNft()
                } label: {
                    Text("Alterar")
                        .frame(maxWidth: 200)
                        .frame(height: 45)
                        .foregroundStyle(!viewModel.isDiferrent ? Color.white : Color.white.opacity(0.4))
                        .font(.system(size: 18, weight: .bold))
                        .background(!viewModel.isDiferrent ? Color.buttonColor : Color.buttonColor.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .disabled(viewModel.isDiferrent)
                
                Spacer()
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertVisible) {
            Button("OK") {
            }
        } message: {
            Text(viewModel.alertErrorMessage)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

#Preview {
    @State var userNft: UserNftModel = UserNftModel(id: "aaaa", nftImageName: "fox", nftValue: "200")
    
    return NftDetailView(userNft: userNft)
}
