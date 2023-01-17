//
//  ImageLoader.swift
//  MoveOn
//
//  Created by Garry on 15/11/22.
//

import SwiftUI

struct ImageLoader: View {
    let url: String
    let width: CGFloat
    let height: CGFloat
    
    @State var isFailure = false
    
    var body: some View {
        if !isFailure {
            AsyncImage(url: url.toURL()) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                    
                } else if phase.error != nil {
                    
                    HStack {
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .foregroundColor(Color(.systemGray3))
                    .frame(width: width, height: height)
                    .background(
                        Rectangle().foregroundColor(Color(.white))
                    )
                    
                } else {
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .foregroundColor(Color(.systemGray3))
                        .frame(width: width, height: height)
                        .background(
                            Rectangle()
                                .foregroundColor(Color(.white))
                            
                        )
                }
            }
            
        } else {
            HStack {
                Image(systemName: "person.crop.circle.badge.exclamationmark")
                    .foregroundColor(.white)
                    .padding()
            }
            .foregroundColor(Color(.systemGray3))
            .frame(width: width, height: height)
            .background(
                Rectangle().foregroundColor(Color(.white))
            )
        }
    }
}
