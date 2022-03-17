//
//  SearchCafeViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit
import MapKit

class SearchCafeViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    
    var searchCoordinate: CLLocationCoordinate2D!
    
    @IBAction func tabSearchButton(_ sender: Any) {
        
        self.setSearching(searching: true)
        
        // If there's no string in the text field
        if locationTextfield.text == "" {
            self.showFailureMessage(title: "Enter a Location", message: "Please enter a location or address.")
            setSearching(searching: false)
            return
        }
        
        getCoordinate(addressString: locationTextfield.text ?? "") { (coordinate, error) in
            if error == nil {
                self.searchCoordinate = coordinate
                
                NetworkClient.getSearchResults(latitude: coordinate.latitude, longitude: coordinate.longitude) {
                    result in
                    switch result {
                    case .success(let searchResponse):
                        SearchResultsModel.businesses = searchResponse.businesses
                        self.performSegue(withIdentifier: "completeSearch", sender: nil)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                self.showFailureMessage(title: "Invalid Location", message: "Please enter a valid location or address.")
                self.setSearching(searching: false)
                return
            }
            self.setSearching(searching: false)
        }
    }
    
    func setSearching(searching: Bool){
        if searching {
            searchActivityIndicator.startAnimating()
            locationTextfield.isEnabled = false
            searchButton.isEnabled = false
        } else {
            searchActivityIndicator.stopAnimating()
            locationTextfield.isEnabled = true
            searchButton.isEnabled = true
        }
    }
    
    private func getCoordinate( addressString: String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) {(placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarVC = segue.destination as! UITabBarController
        let navVC = tabBarVC.viewControllers![0] as! UINavigationController
        let resultsMapVC = navVC.topViewController as! ResultsMapViewController
        resultsMapVC.resultCoordinate = self.searchCoordinate
    }
}
