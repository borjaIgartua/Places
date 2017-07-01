//
//  ViewController.swift
//  Places
//
//  Created by Borja Igartua Pastor on 8/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class PlacesViewController: UIViewController, MKMapViewDelegate, PlaceInteractorDelegate {
    var interactor: PlacesInteractor?
    var annotations = [MKPointAnnotation]()

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var placesMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor = PlacesInteractor()
        self.interactor!.delegate = self
        
        let addPlaceGesture = UILongPressGestureRecognizer(target: self, action: #selector(PlacesViewController.addPlaceGesture(gesture:)))
        addPlaceGesture.cancelsTouchesInView = false
        self.placesMapView.addGestureRecognizer(addPlaceGesture)
        
        self.placesMapView.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.interactor?.startUpdatingLocation()
        self.interactor?.retrivePlaces()
    }

    @IBAction func addPlaceButtonPressed(_ sender: UIButton) {
        
        self.showAddPlaceModule()
    }
    
    func showAddPlaceModule(location: CLLocationCoordinate2D? = nil, place: Place? = nil) {
        
        let navController = self.storyboard?.instantiateViewController(withIdentifier: "AddPlaceNavigationControllerSBID") as! UINavigationController
        let viewController = navController.viewControllers[0] as! AddPlaceViewController
        
        let interactor = AddPlaceInteractor()
        interactor.location = location
        interactor.place = place
        
        viewController.interactor = interactor
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func addPlaceGesture(gesture: UILongPressGestureRecognizer) {
        let touchCoordinate = self.placesMapView.convert(gesture.location(in: self.placesMapView), toCoordinateFrom: self.placesMapView)
        self.showAddPlaceModule(location: touchCoordinate)
    }
    
    func annotationButtonPressed(_ button: UIButton) {
        
        let index = button.tag
        
        guard index != -1 else {
            return
        }
        
        print(index)
    }
    
//MARK: - Interactor delegate
    
    func didUpdatePlaces(_ places: [Place]?) {
        
        if let places = places {
            self.placesMapView.removeAnnotations(self.annotations)
            self.annotations.removeAll()
            
            for place in places {
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                annotation.title = place.name
                annotations.append(annotation)
            }
            
            self.placesMapView.addAnnotations(annotations)
        }
    }
    
    func didUpdateLocation(location: CLLocation) {
        
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 600, 600)
        let adjustedRegion = self.placesMapView.regionThatFits(region)
        self.placesMapView.setRegion(adjustedRegion, animated: true)
        self.placesMapView.showsUserLocation = true
    }
    
//MARK: - MKMapView Delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let userLocation = self.interactor?.locationManager.currentLocation {
            if userLocation == annotation.coordinate {
                return nil
            }
        }
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "placeAnnotationIdentifier") as? MKPinAnnotationView
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "placeAnnotationIdentifier")
            view?.canShowCallout = true
            view?.leftCalloutAccessoryView = UIButton(type: .infoLight)
            view?.animatesDrop = true
            
        } else {
            view?.annotation = annotation
        }
        return view
    }
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.startFloatingAnimation()
    }
    
    public func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.stopFloatingAnimation()
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let index = self.annotations.index(of: view.annotation as! MKPointAnnotation) ?? -1
        let selectedPlace = self.interactor?.places[index]
        self.showAddPlaceModule(place: selectedPlace)
    }
}

