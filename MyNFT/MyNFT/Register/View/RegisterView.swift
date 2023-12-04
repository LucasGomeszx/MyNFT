//
//  RegisterView.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 27/11/23.
//

import SwiftUI

struct RegisterView: View {

    @StateObject var viewModel: RegisterViewModel = RegisterViewModel()
    
    var body: some View {
        ZStack {

            Color.backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                HeadView()
                
                Spacer()
                
                RegisterButton()
                
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 50)
        }
        .alert(viewModel.title, isPresented: $viewModel.isPresented) {
            Button("OK") {}
        } message: {
            Text(viewModel.message)
        }
        .environmentObject(viewModel)
        
    }
    
}

//MARK: - HeadView

struct HeadView: View {
    
    @EnvironmentObject var viewModel: RegisterViewModel
    
    var body: some View {

        Text("Register")
            .font(.system(size: 55, weight: .bold))
            .foregroundStyle(.white)
            .padding(.top, 20)
            .padding(.bottom, 50)
        
        Group {
            TextField("", text: $viewModel.email, prompt: Text("E-mail").foregroundStyle(Color.placeholderColor))
                .keyboardType(.emailAddress)
            SecureField("", text: $viewModel.password, prompt: Text("Password").foregroundStyle(Color.placeholderColor))
            SecureField("", text: $viewModel.confirmPassword, prompt: Text("Repita a senha").foregroundStyle(Color.placeholderColor))
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

//MARK: - RegisterButton

struct RegisterButton: View {
    
    @EnvironmentObject var viewModel: RegisterViewModel
    
    var body: some View {
        Button {
            viewModel.registerUser()
        } label: {
            Text("Cadastrar")
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .bold))
                .background(!viewModel.isDisabledRegisterButton ? Color.buttonColor : Color.buttonColor.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .disabled(viewModel.isDisabledRegisterButton)
    }
}

#Preview {
    RegisterView()
}
