//
//  UIViewController+Extension.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation
import UIKit
import MapKit

extension UIViewController {
    
    @IBAction func goBackToSearch(_ sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
    
    func showFailureMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func zoomInToLocation(mapView: MKMapView, coordinate: CLLocationCoordinate2D, latMeters: Double, longMeters: Double) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: latMeters, longitudinalMeters: longMeters)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
