//
//  MoveOnApp.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import SwiftUI
import Firebase

@main
struct MoveOnApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @AppStorage("loginStatus") var loginStatus = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
