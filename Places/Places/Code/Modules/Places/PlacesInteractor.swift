//
//  PlacesInteractor.swift
//  Places
//
//  Created by Borja Igartua Pastor on 8/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class PlacesInteractor {
    let locationManager = LocationManager()
    weak var delegate: PlaceInteractorDelegate?
    
    var places = [Place]()
    
    func retrivePlaces()    {
        
        places.removeAll()
                
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
                let managedContext = appDelegate.persistentContainer.viewContext
                let fetchRequest = Place.placeFetchRequest()
                
                if let retrievedPlaces = try? managedContext.fetch(fetchRequest) {
                    self.places.append(contentsOf: retrievedPlaces)
                }
                
                self.delegate?.didUpdatePlaces(self.places)
        }
    }
    
    func startUpdatingLocation() {
        
        self.locationManager.startUpdatingLocation { [weak delegate = self.delegate]  locations  in
            self.locationManager.stopUpdatingLocation()
            delegate?.didUpdateLocation!(location: locations[0])
        }
    }
}

@objc protocol PlaceInteractorDelegate: class {
    
    func didUpdatePlaces(_ places: [Place]?)
    @objc optional func didUpdateLocation(location: CLLocation)
}
