//
//  MapView.swift
//  MoveOn
//
//  Created by Garry on 17/11/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapView: View {
    @ObservedObject var viewModel = LocationViewModel()
    var body: some View {
        MapViewRepresentable()
            .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
