//
//  MapViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/5/26.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
//    let locationManager = CLLocationManager()
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //
//        mapView.delegate = self
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//            locationManager.requestLocation()
//        }
//        
//        
//        
//        // location set
//        let sourceLocation = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
//        let destinationLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
//        
//        // cerate placemark
//        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
//        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
//        
//        // use mkmapitem mark route
//        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
//        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
//        
//        // set pin
//        let sourceAnnotation = MKPointAnnotation()
//        sourceAnnotation.title = "Times Square"
//        
//        if let location = sourcePlacemark.location {
//            sourceAnnotation.coordinate = location.coordinate
//        }
//        
//        
//        let destinationAnnotation = MKPointAnnotation()
//        destinationAnnotation.title = "Empire State Building"
//        
//        if let location = destinationPlacemark.location {
//            destinationAnnotation.coordinate = location.coordinate
//        }
//        
//        // show pin in map
//        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
//        
//        // mkdirectionRequest to calculate route
//        let directionRequest = MKDirectionsRequest()
//        directionRequest.source = sourceMapItem
//        directionRequest.destination = destinationMapItem
//        directionRequest.transportType = .automobile
//        
//        
//        let directions = MKDirections(request: directionRequest)
//        
//        // show two position in map.
//        directions.calculate {
//            (response, error) -> Void in
//            
//            guard let response = response else {
//                if let error = error {
//                    print("Error: \(error)")
//                }
//                
//                return
//            }
//            
//            let route = response.routes[0]
//            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
//            
//            let rect = route.polyline.boundingMapRect
//            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
//        }
//        
//
//        
//    }
//    
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let renderer = MKPolylineRenderer(overlay: overlay)
//        renderer.strokeColor = UIColor.red
//        renderer.lineWidth = 4.0
//        
//        return renderer
//    }
//
//    
//    func setupData() {
//        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
//            let title =  ""
//            let coordinate = CLLocationCoordinate2DMake(37.703026, -121.759735)
//            let regionRadius = 300.0
//            
//            let region = CLCircularRegion(center: CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude), radius: regionRadius, identifier: locationManager.startMonitoring(for: region))
//            
//        }
//    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
}
