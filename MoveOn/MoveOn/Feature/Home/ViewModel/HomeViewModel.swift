//
//  HomeViewModel.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import Foundation
import SwiftUI
import Firebase

final class HomeViewModel: ObservableObject {
    
    @AppStorage("loginStatus") var loginStatus = false
    
    @Published var username = ""
    @Published var profileUrl = "https://i.pinimg.com/originals/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"
    
    @Published var isShowSheet = false
    
    func logOut() {
        try? Auth.auth().signOut()
        withAnimation {
            loginStatus = false
        }
        
    }
    
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
                        print("data", data)
                        self.username = data["username"] as? String ?? ""
                    }
                }
            }
    }
}
