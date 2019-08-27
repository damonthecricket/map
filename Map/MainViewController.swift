//
//  ViewController.swift
//  Map
//
//  Created by Damon Cricket on 24.08.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

// MARK: - MainViewController

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet private weak var mapView: MKMapView?
    private var locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        mapView?.showsCompass = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let coordiante = location.coordinate
            
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region: MKCoordinateRegion = MKCoordinateRegion(center: coordiante, span: span)
            mapView?.setRegion(region, animated: false)
            
            let annotation: MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = coordiante
            annotation.title = "You"
            mapView?.addAnnotation(annotation)
        }
    }
}

