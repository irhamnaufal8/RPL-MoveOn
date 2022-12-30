//
//  ProfileView.swift
//  MoveOn
//
//  Created by Garry on 30/12/22.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.circle.fill")
                .font(.system(size: 70))
                .foregroundColor(Color(UIColor.systemGray3))
                .padding()
            
            VStack(alignment: .leading, spacing: 24) {
                HStack { Spacer() }
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    Text(viewModel.username)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    Text(viewModel.email)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Phone Number")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    Text(viewModel.phoneNumber)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Divider()
                }
            }
            
            Spacer()
            
            Button {
                viewModel.isShowAlert.toggle()
            } label: {
                HStack {
                    Spacer()
                    Text("Log out")
                        .foregroundColor(.primaryPink)
                        .font(.headline)
                    Spacer()
                }
                .padding(12)
                .background(Color.primaryPink.opacity(0.06))
                .cornerRadius(60)
                .padding(.vertical)
            }
            
            Text("Version 0.0 (Beta)")
                .font(.caption)
                .foregroundColor(.black)
                .padding(.top)
        }
        .padding()
        .navigationTitle("")
        .onAppear {
            viewModel.getUserData()
        }
        .alert(isPresented: $viewModel.isShowAlert) {
            Alert(
                title: Text("Log out?"),
                message: Text("Don't go too long. We will miss you :("),
                primaryButton: .default(Text("Sure"), action: {
                    viewModel.logOut()
                }),
                secondaryButton: .cancel()
            )
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
