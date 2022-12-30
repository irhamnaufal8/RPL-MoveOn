//
//  ScannerView.swift
//  MoveOn
//
//  Created by Garry on 30/12/22.
//

import SwiftUI
import CodeScanner

struct ScannerView: View {
    @ObservedObject var viewModel = MapViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            CodeScannerView(
                codeTypes: [.qr],
                completion: { result in
                    if case let .success(code) = result {
                        viewModel.scannedText = code.string
                    }
                }
            )
            
            VStack(alignment: .leading) {
                Text("Your Bicycle Id: \(viewModel.scannedText)")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.textColor)
                    .font(.headline)
                    .padding(.horizontal)
                
                Button {
                    viewModel.isShowQRSheet = false
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        viewModel.checkIn()
                    }
                } label: {
                    HStack {
                        HStack {
                            Spacer()
                            
                            Text("Start Trip")
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            Spacer()
                        }
                        .padding()
                        .background(
                            viewModel.scannedText.isEmpty ? Color(UIColor.systemGray3) : Color.primaryPink
                        )
                        .cornerRadius(25)
                    }
                    .padding()
                }
                .disabled(viewModel.scannedText.isEmpty)
            }
        }
        .background(
            Color.backgroundColor.ignoresSafeArea()
        )
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
