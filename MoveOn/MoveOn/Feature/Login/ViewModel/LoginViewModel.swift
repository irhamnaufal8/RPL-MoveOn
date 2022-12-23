//
//  LoginViewModel.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import SwiftUI
import Firebase

final class LoginViewModel: ObservableObject {
    
    @AppStorage("loginStatus") var loginStatus = false
    
    @Published var user = User()
    @Published var username = ""
    @Published var password = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    
    @Published var isSignUpView = false
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var isButtonDisabled = true
    @Published var isPasswordHidden = true
    
    @MainActor func onStartFetch() {
        self.isError = false
        self.errorMessage = ""
        self.isButtonDisabled = true
    }
    
    func handleAction() {
        Task {
            await onStartFetch()
            if isSignUpView == false {
                loginUser()
            } else {
                createAccount()
            }
        }
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.isError = true
                self.errorMessage = error.localizedDescription
                print(self.errorMessage)
                return
            }
            
            self.isError = false
            self.storeUserData()
            self.loginUser()
            
        }
    }
    
    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.isError = true
                self.errorMessage = error.localizedDescription
                print(self.errorMessage)
                return
            }
            
            self.isError = false
            self.errorMessage = "Successfully log in as user: \(result?.user.uid ?? "")"
            print(self.errorMessage)
            
            withAnimation {
                self.loginStatus = true
            }
        }
    }
    
    private func storeUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = User(id: uid, email: email, username: username, phoneNumber: phoneNumber).toJSON()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(userData) { error in
                if let error = error {
                    self.isError = true
                    self.errorMessage = error.localizedDescription
                    print(self.errorMessage)
                    return
                }
                
                self.isError = false
                self.errorMessage = "Successfully store user data"
                print(self.errorMessage)
            }
    }
    
    func activateButton() {
        if isSignUpView {
            if email != "" && password != "" && username != "" && phoneNumber != "" {
                self.isButtonDisabled = false
            } else {
                self.isButtonDisabled = true
            }
        } else {
            if email != "" && password != "" {
                self.isButtonDisabled = false
            } else {
                self.isButtonDisabled = true
            }
        }
    }
    
    func loginSignUpToggle() {
        self.isSignUpView.toggle()
    }
    
    func hidePasswordToggle() {
        self.isPasswordHidden.toggle()
    }
}
