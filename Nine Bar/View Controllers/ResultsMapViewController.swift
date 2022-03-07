//
//  ResultsMapViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit
import MapKit

class ResultsMapViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var resultsMapView: MKMapView!
    @IBOutlet weak var backToSearchButton: UIBarButtonItem!
    
    var resultCoordinate: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("segue successful")
        print(self.resultCoordinate)
        self.zoomInToLocation(coordinate: resultCoordinate)
        self.addAnnotions(businessesLocations: SearchResultsModel.businesses)
    }
    
    // MARK: - MKMapViewDelegate
    
    private func addAnnotions(businessesLocations: [BusinessInfo]){
        
        var annotations = [MKPointAnnotation]()
        
        for businessLocation in businessesLocations {
            
            let lat = CLLocationDegrees(businessLocation.coordinates.latitude)
            let long = CLLocationDegrees(businessLocation.coordinates.longitude)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let businessName = businessLocation.name
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(businessName)"
            
            annotations.append(annotation)
        }
        self.resultsMapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "showBusinessDetail", sender: nil)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        let reuseID = "pin"
//
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
//
//        if pinView == nil {
//            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
//            pinView!.canShowCallout = true
//            pinView!.isEnabled = true
//            pinView!.pinTintColor = .red
//            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        } else {
//            pinView!.annotation = annotation
//        }
//        return pinView
//
//    }
    
    func zoomInToLocation(coordinate: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        resultsMapView.setRegion(coordinateRegion, animated: true)
    }
    
}
