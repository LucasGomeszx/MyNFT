//
//  RegisterViewModel.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 27/11/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

class RegisterViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var message: String = ""
    @Published var isPresented: Bool = false
    @Published var goHome: Bool = false
    @Published var title: String = ""
    
    public var isDisabledRegisterButton: Bool {
         let emailValid = isValidEmail(email)
         let passwordValid = isPasswordValid(password)
         let confirmPassword = isPasswordValid(confirmPassword)

         return email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
             !emailValid || !passwordValid || !confirmPassword
     }
     
     private func isValidEmail(_ email: String) -> Bool {
         let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
         let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
         return emailPredicate.evaluate(with: email)
     }

     private func isPasswordValid(_ password: String) -> Bool {
         let passwordRegex = "^.{6,}$"
         let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
         return passwordPredicate.evaluate(with: password)
     }
    
    func registerUser() {
        
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error {
                    self.title = "Erro"
                    self.message = error.localizedDescription
                    self.isPresented.toggle()
                }else {
                    self.title = "Sucesso"
                    self.message = "Usuario cadastrado"
                    self.isPresented.toggle()
                }
            }
        } else {
            title = "Erro"
            message = "Senhar nao sao identicas"
            isPresented.toggle()
        }
    }
    
}
