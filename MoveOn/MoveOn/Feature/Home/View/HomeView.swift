//
//  HomeView.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Color.primaryPink.edgesIgnoringSafeArea(.top)
                    .frame(height: UIScreen.main.bounds.height / 2)
                Color.white
            }
            
            VStack {
                HStack {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        ZStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width / 7.2, height: UIScreen.main.bounds.width / 7.2)
                        }
                    }
                    
                    Text("Hi, \(viewModel.username)!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                VStack {
                    Spacer()
                        .frame(height: 70)
                    
                    ZStack(alignment: .top) {
                        VStack {
                            HStack {
                                Spacer()
                            }
                            
                            VStack {
                                Text("Wanna take a ride?")
                                    .foregroundColor(.black)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                NavigationLink {
                                    MapView()
                                } label: {
                                    Image.letsGoButton
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.main.bounds.width - 90)
                                }
                                
                                Spacer()
                            }
                            .padding(.top, 100)
                        }
                        .background(.white)
                        .cornerRadius(48, corners: .topLeft)
                        
                        HStack {
                            ZStack(alignment: .leading) {
                                Circle()
                                    .foregroundColor(.primaryPink)
                                    .opacity(0.1)
                                    .frame(width: 300, height: 300)
                                    .padding(.leading, -(UIScreen.main.bounds.width / 2.6))
                                    .padding(.bottom, -120)
                                
                                Circle()
                                    .foregroundColor(.primaryPink)
                                    .opacity(0.1)
                                    .frame(width: 300, height: 300)
                                    .padding(.leading, -(UIScreen.main.bounds.width / 3.6))
                                    .padding(.top, -140)
                                
                                VStack(alignment: .leading) {
                                    HStack(spacing: 16) {
                                        VStack(alignment: .leading) {
                                            Text("Your Balance")
                                                .foregroundColor(.black)
                                            Text(String(viewModel.fixedBalance).toCurrency())
                                                .font(.title)
                                                .fontWeight(.bold)
                                        }
                                        
                                        Spacer()
                                        
                                        Button {
                                            viewModel.isShowSheet.toggle()
                                        } label: {
                                            Image(systemName: "plus.app.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 46)
                                                .foregroundColor(.primaryPink)
                                        }
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .clipShape(
                            RoundedRectangle(cornerRadius: 22)
                                .size(width: UIScreen.main.bounds.width - 32, height: 270)
                        )
                        .frame(width: UIScreen.main.bounds.width - 32, height: 120)
                        .background(.white)
                        .cornerRadius(24)
                        .padding(.top, -50)
                        .shadow(color: .black.opacity(0.2), radius: 6, y: 6)
                    }
                }
            }
            
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    ProgressView()
                }
                
            }
        }
        .navigationTitle("")
        .onAppear {
            viewModel.getUserData()
        }
        .sheet(isPresented: $viewModel.isShowSheet) {
            TopUpSheet(viewModel: viewModel)
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            return Alert(
                title: Text("Top Up Succeed"),
                message: Text("Yeay, your balance has been filled! Let's take a ride!"),
                dismissButton: .default(Text("Okay"))
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        HomeView.TopUpSheet(viewModel: HomeViewModel())
    }
}

extension HomeView {
    struct TopUpSheet: View {
        @ObservedObject var viewModel: HomeViewModel
        
        var body: some View {
            VStack {
                Text("Top Up")
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(viewModel.topUpOption, id: \.self) { item in
                        Button {
                            viewModel.selectOption(button: item)
                        } label: {
                            HStack {
                                Spacer()
                                
                                Text(item.rawValue.toCurrency())
                                    .foregroundColor(.black)
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    
                                Spacer()
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                            .background(Color.white)
                        }

                    }
                }
                
                HStack {
                    Text(String(viewModel.balance).toCurrency())
                        .foregroundColor(.black)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
                Spacer()
                
                Button {
                    viewModel.topUpBalance()
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        viewModel.isShowingAlert.toggle()
                    }
                } label: {
                    HStack {
                        Spacer()
                        
                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Spacer()
                    }
                    .padding()
                    .background((viewModel.balance == 0) ? Color(UIColor.systemGray3) : Color.primaryPink)
                    .cornerRadius(25)
                }
                .disabled((viewModel.balance == 0))
            }
            .background {
                Color.white
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
            .padding()
            .presentationDetents([.medium])
            .onDisappear {
                viewModel.balance = 0
            }
        }
    }
}
