//
//  MapViewModel.swift
//  MoveOn
//
//  Created by Garry on 17/11/22.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import CoreLocation
import MapKit

final class MapViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @AppStorage("bicycleId") var bicycleId = ""
    @AppStorage("isOTW") var isOTW = false
    @AppStorage("bill") var bill = 0
    
    @Published var dummyBill = 10000
    @Published var totalBill = 0
    
    @Published var bicycle = [Bicycle]()
    @Published var data = [String : Any]()
    @Published var isShowQRSheet = false
    @Published var isShowAlert = false
    @Published var scannedText = ""
    @Published var fixedBalance = 0
    @Published var time = Timer()
    @Published var totalTime = 0
    @Published var isTimerStart = false
    
    @Published var isShowTutorial = false
    
    func updateBill() {
        totalBill = bill
        totalBill = bill * (minutes + 1)
    }
    
    private var minutes = 0
    private var seconds = 0
    
    func timeSpentText() -> String {
        minutes = (totalTime%3600)/60
        seconds = totalTime % 60
        return "\(minutes):\(seconds)"
    }
    
    func startTimer() {
        if isTimerStart {
            time = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.totalTime += 1
            }
        }
    }
    
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
            }
    }
    
    func checkIn() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("bicycles")
            .document(self.scannedText)
            .getDocument { document, error in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }
                if let document = document, document.exists {
                    let data = document.data()
                    if let data = data {
                        self.bill = data["price"] as? Int ?? 0
                    }
                }
            }
        
        Firestore.firestore().collection("bicycles")
            .document(self.scannedText)
            .updateData(["usedBy" : uid]) { error in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }
                
                withAnimation {
                    self.bicycleId = self.scannedText
                    self.isOTW = true
                }
            }
    }
    
    func endTrip() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.isTimerStart = false
        
        Firestore.firestore().collection("bicycles")
            .document(self.bicycleId)
            .updateData(["usedBy" : ""]) { error in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }
                
                withAnimation {
                    self.bicycleId = ""
                    self.isOTW = false
                }
            }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .updateData(["balance" : fixedBalance-totalBill]) { error in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }
            }
    }
    
    func getUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { document, error in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }
                if let document = document, document.exists {
                    let data = document.data()
                    if let data = data {
                        self.fixedBalance = data["balance"] as? Int ?? 0
                    }
                }
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
