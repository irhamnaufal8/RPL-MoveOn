//
//  MapViewRepresentable.swift
//  MoveOn
//
//  Created by Garry on 16/12/22.
//

import SwiftUI
import MapKit
import Firebase

struct MapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
//    var geopoints: [String : GeoPoint]
    var bicycles = [Bicycle]()
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        for i in bicycles {
            context.coordinator.addAnnotation(withCoordinate: CLLocationCoordinate2D(latitude: i.location?.latitude ?? 0, longitude: i.location?.longitude ?? 0))
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: MapViewRepresentable
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func addAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            self.parent.mapView.addAnnotation(annotation)
            self.parent.mapView.selectAnnotation(annotation, animated: true)
            self.parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
    }
}
