//
//  ProfileViewModel.swift
//  MoveOn
//
//  Created by Garry on 30/12/22.
//

import Foundation
import SwiftUI
import Firebase

final class ProfileViewModel: ObservableObject {
    
    @AppStorage("loginStatus") var loginStatus = false
    @AppStorage("bicycleId") var bicycleId = ""
    @AppStorage("isOTW") var isOTW = false
    @AppStorage("bill") var bill = 0
    
    @Published var username = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    
    @Published var isShowAlert = false
    
    func getUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { document, error in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }
                if let document = document, document.exists {
                    let data = document.data()
                    if let data = data {
                        self.username = data["username"] as? String ?? ""
                        self.email = data["email"] as? String ?? ""
                        self.phoneNumber = data["phoneNumber"] as? String ?? ""
                    }
                }
            }
    }
    
    func logOut() {
        try? Auth.auth().signOut()
        withAnimation {
            loginStatus = false
            bicycleId = ""
            isOTW = false
            bill = 0
        }
        
    }
}
