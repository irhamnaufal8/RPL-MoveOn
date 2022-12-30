//
//  LoginView.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                
                Image.longLogoApp
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 230)
                    .padding(.top, 24)
                
                Spacer()
                
                ScrollView(showsIndicators: false) {
                    if viewModel.isSignUpView {
                        VStack {
                            HStack {
                                Text("Name")
                                    .font(.headline)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            TextField(
                                "Enter your name",
                                text: $viewModel.username
                            )
                            .autocapitalization(.none)
                            .foregroundColor(.textColor)
                            .padding(12)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 46)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                            .onChange(of: viewModel.username) { _ in
                                viewModel.activateButton()
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text("Phone Number")
                                    .font(.headline)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top, 12)
                            
                            HStack {
                                Text("+62")
                                    .foregroundColor(.textColor)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.gray)
                                    .frame(width: 0.5, height: 36)
                                
                                TextField(
                                    "Enter your phone number",
                                    text: $viewModel.phoneNumber
                                )
                            }
                            .keyboardType(.phonePad)
                            .autocapitalization(.none)
                            .foregroundColor(.textColor)
                            .padding(12)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 46)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                            .onChange(of: viewModel.phoneNumber) { _ in
                                
                                viewModel.activateButton()
                            }
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("Email Address")
                                .font(.headline)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        TextField(
                            "Enter your email",
                            text: $viewModel.email
                        )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(.textColor)
                        .padding(12)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 46)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .onChange(of: viewModel.email) { _ in
                            viewModel.activateButton()
                        }
                        
                        HStack {
                            Text("Password")
                                .font(.headline)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                        
                        HStack {
                            if viewModel.isPasswordHidden {
                                SecureField(
                                    "Enter your password",
                                    text: $viewModel.password
                                )
                                
                            } else {
                                TextField(
                                    "Enter your password",
                                    text: $viewModel.password
                                )
                            }
                            
                            Button {
                                viewModel.hidePasswordToggle()
                            } label: {
                                Image(systemName: viewModel.isPasswordHidden ? "eye.slash" : "eye")
                                    .foregroundColor(viewModel.isPasswordHidden ? Color.gray : Color.textColor)
                            }
                        }
                        .autocapitalization(.none)
                        .foregroundColor(.textColor)
                        .padding(12)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 46)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .onChange(of: viewModel.password) { _ in
                            viewModel.activateButton()
                        }
                    }
                    .onSubmit {
                        hideKeyboard()
                    }
                    
                    Group {
                        if viewModel.isError == true {
                            HStack {
                                Text(viewModel.errorMessage)
                                    .font(.caption)
                                    .foregroundColor(.red)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Button {
                        hideKeyboard()
                        viewModel.handleAction()
                    } label: {
                        Text(viewModel.isSignUpView ?
                             "Sign up" :
                                "Log in")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(12)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 46)
                        .background(viewModel.isButtonDisabled ? Color(UIColor.systemGray3) : Color.primaryPink)
                        .cornerRadius(24)
                        .padding()
                    }
                    .disabled(viewModel.isButtonDisabled)
                    
                    
                    Spacer()
                    
                    HStack {
                        Text(viewModel.isSignUpView ?
                             "Already have an account?" :
                                "Don't have an account?")
                        .foregroundColor(.textColor)
                        .font(.body)
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.loginSignUpToggle()
                            }
                        } label: {
                            Text(viewModel.isSignUpView ?
                                 "Log in" :
                                    "Sign up")
                            .foregroundColor(.primaryPink)
                            .font(.body.weight(.bold))
                        }
                    }
                    .padding()
                    .padding(.bottom)
                }
                .padding(.top, 24)
            }
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
        }
        .background(
            Color.backgroundColor.ignoresSafeArea()
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
