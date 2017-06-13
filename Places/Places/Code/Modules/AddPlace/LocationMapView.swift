//
//  LocationMapView.swift
//  Places
//
//  Created by Borja Igartua Pastor on 9/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//
//
// Custom designable view ---> http://supereasyapps.com/blog/2014/12/15/create-an-ibdesignable-uiview-subclass-with-code-from-an-xib-file-in-xcode-6
//

import UIKit
import MapKit
import CoreLocation

@IBDesignable
class LocationMapView: NibDesignable, MKMapViewDelegate {
    private var currentDroppedLocation: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var location: CLLocationCoordinate2D? {
        get {
            return self.currentDroppedLocation
        }
        set {
            
            if let coordinate = newValue {
                
                let region = MKCoordinateRegionMakeWithDistance(coordinate, 200, 200)
                let adjustedRegion = self.mapView.regionThatFits(region)
                self.mapView.setRegion(adjustedRegion, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotation(annotation)
                
                self.currentDroppedLocation = coordinate
            }
        }
    }
    

    
//MARK: - MapView delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "draggableAnnotationIdentifier") as? MKPinAnnotationView
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "draggableAnnotationIdentifier")
            view?.animatesDrop = true
            view?.isDraggable = true
            
        } else {
            view?.annotation = annotation
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        
        if newState == .ending {
            
            self.currentDroppedLocation = view.annotation?.coordinate
        }
    }

}
