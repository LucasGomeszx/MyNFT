//
//  NftDetailCell.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 01/12/23.
//

import SwiftUI

struct NftDetailCell: View {
    
    var body: some View {
        ZStack {
            Color.buttonColor.ignoresSafeArea()
            
            HStack {
                
                Image("klv")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .overlay(RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.white, lineWidth: 1.0)  )
                
                Text("KLV")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
                
                Spacer()
                
                Text("$ 0.0004")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 100)
                    
                Spacer()
                
                VStack {
                    Text("$")
                        .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    
                    Text("= 0.8765")
                        .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 70)
                }
                
                
            }
            .padding()
            
        }
        .overlay(RoundedRectangle(cornerRadius: 25.0)
            .stroke(Color.white, lineWidth: 1.0))
    }
    
}

#Preview {
    NftDetailCell()
}
