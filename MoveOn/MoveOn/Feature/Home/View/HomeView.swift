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
                        Button {
                            viewModel.logOut()
                        } label: {
                            Text("Log Out")
                                .foregroundColor(.red)
                                .font(.headline)
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: (UIScreen.main.bounds.width / 7.2) + 4, height: (UIScreen.main.bounds.width / 7.2) + 4)
                            
                            ImageLoader(
                                url: viewModel.profileUrl,
                                width: UIScreen.main.bounds.width / 7.2,
                                height: UIScreen.main.bounds.width / 7.2
                            )
                            .clipShape(Circle())
                        }
                    }
                    .padding(.trailing)

                    
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView(showsIndicators: false) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hi, \(viewModel.username)!")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Wanna take a ride today?")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    .padding(.bottom, 50)
                    
                    ZStack(alignment: .top) {
                        VStack {
                            HStack {
                                Spacer()
                            }
                            
                            VStack(alignment: .leading) {
                                
                                HStack {
                                    Text("Near you")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    NavigationLink {
                                        
                                    } label: {
                                        HStack {
                                            Text("Browse Map")
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.headline)
                                        }
                                        .foregroundColor(.primaryPink)
                                    }
                                }
                                .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(0...5, id: \.self) {_ in
                                            NavigationLink {
                                                
                                            } label: {
                                                VStack {
                                                    Image("dummy-bicycle")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: UIScreen.main.bounds.width / 2)
                                                    
                                                    HStack {
                                                        Text("150m")
                                                            .font(.caption)
                                                        Spacer()
                                                    }
                                                    
                                                    HStack {
                                                        Text("Polygon MountBike")
                                                            .font(.headline)
                                                        Spacer()
                                                    }
                                                    
                                                    HStack {
                                                        Spacer()
                                                        
                                                        Text("Rp10.000/hour")
                                                            .font(.headline)
                                                            .foregroundColor(.white)
                                                        
                                                        Spacer()
                                                    }
                                                    .padding()
                                                    .background(Color.primaryPink)
                                                    .cornerRadius(14)
                                                }
                                                .foregroundColor(.black)
                                                .padding()
                                                .background(.white)
                                                .cornerRadius(24)
                                                .shadow(color: .black.opacity(0.1), radius: 6, y: 6)
                                                .padding(.vertical)

                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                
                                HStack {
                                    Text("Your history")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    NavigationLink {
                                        
                                    } label: {
                                        HStack {
                                            Text("See all")
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.headline)
                                        }
                                        .foregroundColor(.primaryPink)
                                    }
                                }
                                .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(0...5, id: \.self) {_ in
                                            NavigationLink {
                                                
                                            } label: {
                                                VStack {
                                                    Image("dummy-bicycle")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: UIScreen.main.bounds.width / 2)
                                                    
                                                    HStack {
                                                        Text("3 hours")
                                                            .font(.caption)
                                                        Spacer()
                                                    }
                                                    
                                                    HStack {
                                                        Text("Polygon MountBike")
                                                            .font(.headline)
                                                        Spacer()
                                                    }
                                                    
                                                    HStack {
                                                        Text("Rp30.000")
                                                            .font(.headline)
                                                            .foregroundColor(.black)
                                                        
                                                        Spacer()
                                                    }
                                                }
                                                .foregroundColor(.black)
                                                .padding()
                                                .background(.white)
                                                .cornerRadius(24)
                                                .shadow(color: .black.opacity(0.1), radius: 6, y: 6)
                                                .padding(.vertical)

                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
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
                                            Text("Rp150.000")
                                                .font(.title)
                                                .fontWeight(.bold)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "clock.arrow.circlepath")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40)
                                            .foregroundColor(.black)
                                        
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
        }
        .onAppear {
            viewModel.getUserData()
        }
        .sheet(isPresented: $viewModel.isShowSheet) {
            VStack {
                Text("Top Up")
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        
                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.primaryPink)
                    .cornerRadius(25)
                    .padding()
                }
            }
            .presentationDetents([.medium, .large])
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
