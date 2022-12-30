//
//  LocationManager.swift
//  MoveOn
//
//  Created by Garry on 16/12/22.
//

import CoreLocation
import Firebase
import SwiftUI

final class LocationManager: NSObject, ObservableObject {
    @AppStorage("bicycleId") var bicycleId = ""
    @AppStorage("isOTW") var isOTW = false
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        
        let last = locations.last
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let location = GeoPoint(latitude: last?.coordinate.latitude ?? 0, longitude: last?.coordinate.longitude ?? 0)
        
        Firestore.firestore().collection("users")
            .document(uid)
            .updateData(["location" : location]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        
        if self.isOTW && !self.bicycleId.isEmpty {
            Firestore.firestore().collection("bicycles")
                .document(self.bicycleId)
                .updateData(["location" : location]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
        }
    }
}
