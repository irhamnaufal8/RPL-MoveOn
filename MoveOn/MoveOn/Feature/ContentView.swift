//
//  ContentView.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("loginStatus") var loginStatus = false
    var body: some View {
        NavigationView {
            ZStack {
                if loginStatus {
                    HomeView()
                } else {
                    LoginView()
                }
            }
        }
        .tint(.primaryPink)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
