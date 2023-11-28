//
//  LoginView.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 27/11/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    LoginHeadView()
                    
                    Spacer()
                    
                    LoginButtonView()
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
            .alert("Erro", isPresented: $viewModel.isPresented) {
                Button("OK") {
                }
            } message: {
                Text(viewModel.errorMessage)
            }
            .navigationDestination(isPresented: $viewModel.goRegister) {
                RegisterView()
            }
            .navigationDestination(isPresented: $viewModel.goHome) {
                Color.red
            }
            .environmentObject(viewModel)
        }
    }
    
}

struct LoginHeadView: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        Text("Login")
            .font(.system(size: 55, weight: .bold))
            .foregroundStyle(.white)
            .padding(.top, 50)
        
        Spacer()
        
        Group {
            TextField("", text: $viewModel.email, prompt: Text("E-mail").foregroundStyle(Color.placeholderColor))
                .keyboardType(.emailAddress)
            SecureField("", text: $viewModel.password, prompt: Text("Password").foregroundStyle(Color.placeholderColor))
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
        
    }
}

struct LoginButtonView: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        Button {
            viewModel.loginUser()
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
            viewModel.goRegisterView()
        } label: {
            Text("Ainda não tem conta? Cadastre-se")
                .frame(height: 45)
                .foregroundStyle(.white)
                .font(.system(size: 16, weight: .bold))
        }
    }
}

#Preview {
    LoginView()
}
