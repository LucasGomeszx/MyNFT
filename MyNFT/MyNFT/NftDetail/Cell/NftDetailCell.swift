//
//  NftDetailCell.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 01/12/23.
//

import SwiftUI

struct NftDetailCell: View {
    
    @Binding var criptoValue: Double?
    @Binding var nftValur: String
    @Binding var imageName: String
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            
            HStack {
                
                Image(imageName)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .overlay(RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.white, lineWidth: 1.0)  )
                
                Text(imageName)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
                
                Spacer()
                
                Text("= \(convertCripto())")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                
            }
            .padding()
            
        }
        .overlay(RoundedRectangle(cornerRadius: 25.0)
            .stroke(Color.white, lineWidth: 1.0))
    }
    
    private func convertCripto() -> String {
        let nftValue = Double(nftValur)
        guard let nftValue = nftValue else {return ""}
        let value = nftValue * (criptoValue ?? 0)
        let formattedValue = String(format: "%.5f", value)
        return formattedValue
    }
    
}

#Preview {
    @State var criptoValue: Double? = 10
    @State var nftValue: String = "5000"
    @State var imageName: String = "btc"
    return NftDetailCell(criptoValue: $criptoValue, nftValur: $nftValue, imageName: $imageName)
}
