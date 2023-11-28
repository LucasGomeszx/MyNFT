//
//  LoginView.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 27/11/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var goRegister: Bool = false
    @State var goHome: Bool = false
    @State var isPresented: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Login")
                        .font(.system(size: 55, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    Group {
                        TextField("", text: $email, prompt: Text("E-mail").foregroundStyle(Color.placeholderColor))
                            .keyboardType(.emailAddress)
                        SecureField("", text: $password, prompt: Text("Password").foregroundStyle(Color.placeholderColor))
                    }
                    .frame(height: 40)
                    .padding(7)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.fieldBorderColor, lineWidth: 2)
                    })
                    .padding(7)
                    .foregroundStyle(.white)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    
                    Spacer()
                    
                    Button {
                        goHome.toggle()
                    } label: {
                        Text("Login")
                            .frame(width: 180, height: 45)
                            .foregroundStyle(.white)
                            .font(.system(size: 18, weight: .bold))
                            .background(Color.buttonColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Spacer()
                    
                    Button{
                        goRegister.toggle()
                    } label: {
                        Text("Ainda não tem conta? Cadastre-se")
                            .frame(height: 45)
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
            .alert("Senha incorreta", isPresented: $isPresented) {
                Button("OK") {
                }
            } message: {
                Text(errorMessage)
            }
            .navigationDestination(isPresented: $goRegister) {
                
            }
            .navigationDestination(isPresented: $goHome) {
                
            }
        }
    }
    
    
    
}

#Preview {
    LoginView()
}
