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
    @Published var balance = 0
    @Published var fixedBalance = 0
    
    @Published var isShowSheet = false
    @Published var topUpNominal = 0
    
    @Published var alertHandling: AlertHandling?
    
    @Published var isLoading = false
    
    enum TopUpOption: String {
        case one = "10000"
        case two = "20000"
        case three = "50000"
        case four = "100000"
    }
    
    enum AlertHandling: String, Identifiable {
        var id: String { rawValue }
        case topUpSuccess
        case balanceIsZero
    }
    
    let topUpOption: [TopUpOption] = [
        .one, .two, .three, .four
    ]
    
    func selectOption(button: TopUpOption) {
        switch button {
        case .one:
            self.balance = 10000
        case .two:
            self.balance = 20000
        case .three:
            self.balance = 50000
        case .four:
            self.balance = 100000
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
                        self.username = data["username"] as? String ?? ""
                        self.profileUrl = data["profilePictureUrl"] as? String ?? ""
                        self.fixedBalance = data["balance"] as? Int ?? 0
                    }
                }
            }
    }
    
    func topUpBalance() {
        isLoading = true
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .updateData(["balance" : fixedBalance+balance]) { error in
                guard error == nil else {
                    print("error", error ?? "")
                    self.isLoading = false
                    return
                }
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isShowSheet = false
                    self.getUserData()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    self.alertHandling = .topUpSuccess
                }
            }
    }
}
