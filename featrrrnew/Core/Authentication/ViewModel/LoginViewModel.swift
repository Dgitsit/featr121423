//
//  LoginViewModel.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/23/23.
//

import Foundation
import FirebaseAuth



class LoginViewModel: ObservableObject {
    //@Published var errorMessage = ""
    @Published var email = ""
    @Published var password = ""
    @Published var showAlert = false
    @Published var authError: AuthError?
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            try await AuthService.shared.login(withEmail: email, password: password)
        } catch {
            let authError = AuthErrorCode.Code(rawValue: (error as NSError).code)
            self.showAlert = true
            self.authError = AuthError(authErrorCode: authError ?? .userNotFound)
        }
    }
    
    /*func login(withEmail email: String, password: String) async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
        
    }*/
    
   /*func signInAnonymous() async throws {
      await AuthService.shared.signInAnonymous()
    }*/
    
}













/*class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
      try await  AuthService.shared.login(withEmail: email, password: password)
    }
 
 
 func login() {
     guard validate() else {
         return
     }
     Auth.auth().signIn(withEmail: email, password: password)
 }
 
 private func validate() -> Bool {
     errorMessage = ""
     guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
         
         errorMessage = "Please fill in all fields."
         return false
     }
         guard email.contains("@") && email.contains(".") else {
             errorMessage = "Please enter valid email."
             return false
         }
     return true
 }
 
 
 
 
 
 
}*/
