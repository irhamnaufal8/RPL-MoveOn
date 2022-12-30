//
//  MapView.swift
//  MoveOn
//
//  Created by Garry on 17/11/22.
//

import SwiftUI
import CoreLocation
import MapKit
import Firebase

struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            if !viewModel.isOTW {
                ZStack(alignment: .bottom) {
                    MapViewRepresentable(bicycles: viewModel.bicycle)
                        .ignoresSafeArea()
                        .onAppear {
                            viewModel.getBicycles()
                        }
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                viewModel.isShowTutorial.toggle()
                            }, label: {
                                Image(systemName: "questionmark.circle")
                                    .font(.system(size: 36))
                                    .foregroundColor(.primaryPink)
                            })
                            
                        }
                        .padding(.trailing)
                        
                        VStack {
                            Button {
                                viewModel.isShowQRSheet.toggle()
                            } label: {
                                HStack {
                                    HStack {
                                        Spacer()
                                        
                                        Text("Scan QR Code")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.primaryPink)
                                    .cornerRadius(25)
                                }
                                .padding()
                            }
                        }
                        .background {
                            Color.backgroundColor
                        }
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .sheet(isPresented: $viewModel.isShowQRSheet) {
                    ScannerView()
                }
            } else {
                ZStack(alignment: .bottom) {
                    MapViewRepresentable(bicycles: [])
                        .ignoresSafeArea()
                        .onAppear {
                            viewModel.getUserData()
                            viewModel.isTimerStart = true
                            viewModel.startTimer()
                        }
                    VStack {
                        Text("You're On The Way!")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(6)
                            .padding(.horizontal)
                            .background {
                                Color.primaryPink
                            }
                            .cornerRadius(50)
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                Spacer()
                                VStack {
                                    Text("Your Bill")
                                        .font(.caption)
                                    
                                    Text(String(viewModel.totalBill).toCurrency())
                                        .font(.headline)
                                }
                                Spacer()
                                
                                VStack {
                                    Text("Time Spent")
                                        .font(.caption)
                                    
                                    Text(viewModel.timeSpentText())
                                        .font(.headline)
                                }
                                .onChange(of: viewModel.totalTime) { _ in
                                    viewModel.updateBill()
                                }
                                Spacer()
                                
                                VStack {
                                    Text("Your Balance")
                                        .font(.caption)
                                    
                                    Text(String(viewModel.fixedBalance).toCurrency())
                                        .font(.headline)
                                }
                                Spacer()
                            }
                            
                            Button {
                                viewModel.isShowAlert.toggle()
                            } label: {
                                HStack {
                                    HStack {
                                        Spacer()
                                        
                                        Text("End Trip")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.primaryPink)
                                    .cornerRadius(25)
                                }
                                .padding()
                            }
                        }
                        .padding(.top)
                        .background {
                            Color.backgroundColor
                        }
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationTitle("")
        .alert(isPresented: $viewModel.isShowAlert) {
            Alert(
                title: Text("End Trip?"),
                message: Text("This trip will cost you \(String(viewModel.totalBill).toCurrency())"),
                primaryButton: .default(Text("Sure"), action: {
                    viewModel.endTrip()
                    self.mode.wrappedValue.dismiss()
                }),
                secondaryButton: .cancel()
            )
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                viewModel.isShowTutorial = true
            }
        }
        .fullScreenCover(isPresented: $viewModel.isShowTutorial) {
            TutorialView()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
