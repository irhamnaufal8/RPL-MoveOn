//
//  MapViewModel.swift
//  MoveOn
//
//  Created by Garry on 17/11/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import CoreLocation
import MapKit

final class MapViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var bicycle = [Bicycle]()
    @Published var data = [String : Any]()
    
    func getBicycles() {
        Firestore.firestore().collection("bicycles")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error \(String(describing: error?.localizedDescription))")
                    return
                }

                self.bicycle = documents.compactMap { document -> Bicycle? in
                    do {
                        return try document.data(as: Bicycle.self)
                    } catch {
                        print("Error decoding document: \(error)")
                        return nil
                    }
                }

                print("Bicycle: \(self.bicycle)")
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .denied {
            print("denied")
        } else if status == .authorizedWhenInUse {
            print("authorized")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
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
    }
    
    func position(locations: [CLLocation]) -> CLLocationCoordinate2D {
        let last = locations.last
        
        return CLLocationCoordinate2D(latitude: last?.coordinate.latitude ?? 0, longitude: last?.coordinate.longitude ?? 0)
    }
}

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: -80.5), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowLocationPermission() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            print("Location Error #1")
            return
        }
        
        DispatchQueue.main.async {
            self.mapRegion = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error #2:")
        print(error.localizedDescription)
    }
    
}
