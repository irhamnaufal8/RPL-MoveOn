//
//  TutorialView.swift
//  MoveOn
//
//  Created by Garry on 30/12/22.
//

import SwiftUI

struct TutorialView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.primaryPink)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.textColor.opacity(0.2))
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("How to Rent a Bicycle")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.textColor)
                .multilineTextAlignment(.center)
            
            TabView {
                VStack(spacing: 60) {
                    Image.imageWalk
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.main.bounds.width - 240)
                        .padding(.top)
                    
                    Text("Go to the nearest bicycle around you.")
                        .foregroundColor(.textColor)
                }
                
                VStack(spacing: 60) {
                    Image.imageScan
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.main.bounds.width - 240)
                        .padding(.top)
                    
                    Text("Scan the QR Code on the bicycle.")
                        .foregroundColor(.textColor)
                }
                
                VStack(spacing: 60) {
                    Image.imageBicycle
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.main.bounds.width - 240)
                        .padding(.top)
                    
                    Text("Enjoy your ride!")
                        .foregroundColor(.textColor)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: UIScreen.main.bounds.width)
            
            Spacer()
            
            Button {
                self.mode.wrappedValue.dismiss()
            } label: {
                HStack {
                    HStack {
                        Spacer()
                        
                        Text("Got It!")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.primaryPink)
                    .cornerRadius(25)
                }
            }
            .padding()
        }
        .background(
            Color.backgroundColor.ignoresSafeArea()
        )
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
