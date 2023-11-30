//
//  AddNftView.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import SwiftUI

struct AddNftView: View {
    
    @State var valor: String = ""
    
    var body: some View {
        ZStack {
            
            Color.backgroundColor.ignoresSafeArea()
            
            VStack {
                
                Text("Adicionar NFT a venda.")
                    .foregroundStyle(.white)
                    .font(.system(size: 25, weight: .bold))
                    .padding(.bottom, 30)
                
                Image("fox")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 300, maxHeight: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .overlay(RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.white, lineWidth: 2.0)  )
                    .shadow(radius: 20)
                
                Text("Digite o valor do NFT.")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.top, 30)
                    
                
                TextField("", text: $valor, prompt: Text("Digite valor em $:").foregroundStyle(Color.placeholderColor))
                    .keyboardType(.decimalPad)
                    .frame(height: 40)
                    .padding(7)
                    .padding(.leading, 15)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.fieldBorderColor, lineWidth: 2)
                            .padding(7)
                    })
                    .foregroundStyle(.white)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)

                
                Spacer()
                
                Button {
                   print(isValidDollarValue(valor))
                } label: {
                    Text("Adicionar")
                        .frame(width: 180, height: 45)
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .bold))
                        .background(Color.buttonColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                
                Spacer()
            }
            .padding(.top, 30)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func isValidDollarValue(_ value: String) -> Bool {
        let pattern = #"^\$?\d+(\.\d{1,2})?$"#
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: value.utf16.count)
        let matches = regex.matches(in: value, options: [], range: range)

        return !matches.isEmpty
    }
    
}

#Preview {
    AddNftView()
}
