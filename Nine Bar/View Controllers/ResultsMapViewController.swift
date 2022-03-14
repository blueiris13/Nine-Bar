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
                print("request successful!!!")
                print(detailResponse)
                BusinessDetailModel.businessDetail = detailResponse
                self.performSegue(withIdentifier: "showBusinessDetail", sender: nil)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        resultsMapView.deselectAnnotation(view.annotation, animated: true)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! CafeDetailViewController
        detailVC.businessID = self.selectedBusinessID
    }
        
    func zoomInToLocation(coordinate: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        resultsMapView.setRegion(coordinateRegion, animated: true)
    }
}
