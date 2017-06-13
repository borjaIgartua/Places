//
//  LocationManager.swift
//  Places
//
//  Created by Borja Igartua Pastor on 8/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    
    typealias UpdateLocationHandler = ([CLLocation]) -> ()
    var updateLocationHandler: UpdateLocationHandler?
    
    func startUpdatingLocation(updateLocationHandler: @escaping UpdateLocationHandler) {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            self.updateLocationHandler = updateLocationHandler
        }
    }
    
    func stopUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.currentLocation = locations[0].coordinate
        
        if let updateLocationHandler = self.updateLocationHandler {
            updateLocationHandler(locations)
        }
    }
}
