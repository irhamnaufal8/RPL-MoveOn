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
    var body: some View {
        MapViewRepresentable(bicycles: viewModel.bicycle)
            .ignoresSafeArea()
            .onAppear {
                viewModel.getBicycles()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
