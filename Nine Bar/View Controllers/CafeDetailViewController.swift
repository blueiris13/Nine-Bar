//
//  CafeDetailViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit
import Kingfisher
import CoreData
import MapKit

class CafeDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIBarButtonItem!
        
    @IBOutlet weak var storeProfileImageView: UIImageView!
    
    @IBOutlet weak var businessName: UILabel!

    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var directionButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
      
    @IBOutlet weak var storeMapView: MKMapView!
    
    var businessID: String = ""
    
    var favorite: Bool = false
    
    var stores = [Store]()
        
    var storeCoordinate: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        
        businessID = BusinessDetailModel.businessDetail.id
        
        let storeFetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        if let result = try? DataController.shared.viewContext.fetch(storeFetchRequest) {
            stores = result
        }
        
        for store in stores {
            if store.id == businessID {
                favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                favorite = true
            }
        }
        
        businessName.text = BusinessDetailModel.businessDetail.name
        
        let url = URL(string: BusinessDetailModel.businessDetail.imageUrl)
        storeProfileImageView.kf.setImage(with: url)
        storeProfileImageView.layer.cornerRadius = 15.0
        storeProfileImageView.clipsToBounds = true
        
        // Setting map view
        self.storeCoordinate = self.createCoordinate()
        self.addAnnotation()
        
        zoomInToLocation(mapView: self.storeMapView, coordinate: storeCoordinate, latMeters: 1000, longMeters: 1000)
        
    }
    
    // MARK: Button Actions
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func callStore(_ sender: Any) {
        if let url = URL(string: "tel://" + BusinessDetailModel.businessDetail.phone) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openStoreWebsite(_ sender: Any) {
        if let url = URL(string: BusinessDetailModel.businessDetail.url) {
            UIApplication.shared.open(url)
        } else {
            showFailureMessage(title: "Can't Open a Website", message: "Website is not available.")
        }
    }
    
    @IBAction func getDirection(_ sender: Any) {
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=&daddr=\(self.storeCoordinate.latitude),\(self.storeCoordinate.longitude)&directionsmode=driving")!)
        } else {
            showFailureMessage(title: "Can't open the Direction", message: "Google Maps is not available on this device.")
        }
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
       
        // If the selected store is already in the favorite list, remove from the favorite list.
        if favorite {
            return
        } else {
            let store = Store(context: DataController.shared.viewContext)
        
            // Save the business id, name, and profile image
            store.id = BusinessDetailModel.businessDetail.id
            store.name = BusinessDetailModel.businessDetail.name
            
            let imageData = self.storeProfileImageView.image?.pngData()
            store.image = imageData
            
            try? DataController.shared.viewContext.save()
            
            favorite = true
            favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        }
    }
    
    // MARK: Collection View Delegate
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BusinessDetailModel.businessDetail.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageViewCell", for: indexPath) as! CafeDetailCollectionViewCell
        
        let url = URL(string: BusinessDetailModel.businessDetail.photos[(indexPath).row])
        cell.cellImageView.kf.setImage(with: url)
        return cell
    }
    
    // MARK: Map View related functions
    
    private func createCoordinate() -> CLLocationCoordinate2D {
        
        let lat = CLLocationDegrees(BusinessDetailModel.businessDetail.coordinates.latitude)
        let long = CLLocationDegrees(BusinessDetailModel.businessDetail.coordinates.longitude)
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        return coordinate
    }
    
    private func addAnnotation(){
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.storeCoordinate
        self.storeMapView.addAnnotation(annotation)
    }
}
