//
//  LoginViewModel.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 28/11/23.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var goRegister: Bool = false
    @Published var goHome: Bool = false
    @Published var isPresented: Bool = false
    @Published var errorMessage: String = ""
    
    public func goRegisterView() {
        goRegister.toggle()
    }
    
    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                self.errorMessage = error.localizedDescription
                self.isPresented.toggle()
            } else {
                self.goHome.toggle()
            }
        }
    }
    
}
