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
    var selectedBusinessID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomInToLocation(mapView: self.resultsMapView, coordinate: self.resultCoordinate, latMeters: 3000, longMeters: 3000)
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
            annotation.subtitle = businessLocation.id
            
            annotations.append(annotation)
        }
        self.resultsMapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedBusinessID = view.annotation?.subtitle ?? ""
        
        NetworkClient.getBusinessDetail(businessID: self.selectedBusinessID) {
            result in
            switch result {
            case .success(let detailResponse):
                BusinessDetailModel.businessDetail = detailResponse
                self.performSegue(withIdentifier: "showBusinessDetail", sender: nil)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        resultsMapView.deselectAnnotation(view.annotation, animated: true)
    }
}
