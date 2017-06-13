//
//  AddPlaceInteractor.swift
//  Places
//
//  Created by Borja Igartua Pastor on 8/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class AddPlaceInteractor {
    var location: CLLocationCoordinate2D?
    var place: Place?
    
//MARK: - Saving Place
    
    func fillCurrentData(name: inout String?, description: inout String?, coordinate: inout CLLocationCoordinate2D?) {
        
        if let lat = self.location?.latitude, let long = self.location?.longitude {
            coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
        } else if let lat = self.place?.latitude, let long = self.place?.longitude {
            coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        
        if let nm = place?.name {
            name = nm
        }
        
        if let dec = place?.placeDescription {
            description = dec
        }
        
    }
    
    func savePlace(name: String?, description: String?, coordinate: CLLocationCoordinate2D?) throws {
        
        guard let nm = name else {
            throw PlacesError.NamePlaceIsRequired
        }
        
        guard !nm.isEmpty else {
            throw PlacesError.NamePlaceIsRequired
        }
        
        if let place = self.place {
            try self.updatePlace(place, withName: nm, description: description, coordinate: coordinate)
            
        } else {
            try self.addPlace(name: nm, description: description, coordinate: coordinate)
        }
    }
    
    private func addPlace(name: String?, description: String?, coordinate: CLLocationCoordinate2D?) throws {
     
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw PlacesError.unknown
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Place", in: managedContext)!
        let place = NSManagedObject(entity: entity, insertInto: managedContext) as? Place
        
        if let place = place {
            self.setValuesIntoPlace(place, withName: name, description: description, coordinate: coordinate)
        }
        
        try managedContext.save()
    }
    
    private func updatePlace(_ place: Place, withName name: String?, description: String?, coordinate: CLLocationCoordinate2D?) throws {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw PlacesError.unknown
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = Place.placeFetchRequest()
//        let latPredicate = NSPredicate(format: "latitude = \(place.latitude)")
//        let longPredicate = NSPredicate(format: "longitude = \(place.longitude)")
//        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [latPredicate, longPredicate])
        fetchRequest.predicate = NSPredicate(format: "latitude = \(place.latitude.roundTo7) AND longitude = \(place.longitude.roundTo7)")
        
        let fetchResults = try managedContext.fetch(fetchRequest)
        if fetchResults.count == 1 {
            
            let place = fetchResults[0]
            self.setValuesIntoPlace(place, withName: name, description: description, coordinate: coordinate)
            
            try managedContext.save()
        }
    }
    
    private func setValuesIntoPlace(_ place: Place, withName name: String?, description: String?, coordinate: CLLocationCoordinate2D?) {
        
        place.setValue(name, forKeyPath: "name")
        place.setValue(description, forKey: "placeDescription")
        
        if let latitude = coordinate?.latitude {
            place.setValue(latitude.roundTo7, forKey: "latitude")
        }
        
        if let longitude = coordinate?.longitude {
            place.setValue(longitude.roundTo7, forKey: "longitude")
        }
    }
}
