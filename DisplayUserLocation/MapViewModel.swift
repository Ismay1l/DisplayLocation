//
//  MapViewModel.swift
//  DisplayUserLocation
//
//  Created by Ismayil Ismayilov on 5/18/24.
//

import Foundation
import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(
        latitude: 40.893908,
        longitude: -74.063124
    )
    static let defaultSpan = MKCoordinateSpan(
        latitudeDelta: 0.05,
        longitudeDelta: 0.05
    )
}
 
final class MapViewModel: NSObject, ObservableObject {
    
    @Published var region = MKCoordinateRegion(
        center: MapDetails.startingLocation,
        span: MapDetails.defaultSpan
    )
    
    var locationManager: CLLocationManager?
    var isRestricted: ((String) -> Void)?
    var isDenied: ((String) -> Void)?
    
    func checkIfLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            
        }
    }
    
    private  func checkIfAuthorized() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            isRestricted!("Your location is restricted.")
        case .denied:
             isDenied! ("You have denied this app location permisson. Go into your settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(
                center: locationManager.location!.coordinate,
                span: MapDetails.defaultSpan
            )
        @unknown default:
            break
        }
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
         checkIfAuthorized()
    }
}
