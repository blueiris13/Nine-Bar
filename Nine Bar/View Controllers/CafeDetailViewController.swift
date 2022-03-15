//
//  CafeDetailViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit
import Kingfisher
import CoreData

class CafeDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    @IBOutlet weak var storeProfileImageView: UIImageView!
    
    @IBOutlet weak var businessName: UILabel!

    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var directionButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
      
    var businessID: String = ""
    
    var imageArray = [UIImage]()
    
    var imgArray = [UIImage(named: "hello"), UIImage(named: "hello"), UIImage(named: "hello")]
    
    var favorite: Bool = false
    
    var stores = [Store]()
    
    var storeIndex = 0
    
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
        
        for imageUrl in BusinessDetailModel.businessDetail.photos {
            self.downloadImage(urlString: imageUrl)
        }
        
        businessName.text = BusinessDetailModel.businessDetail.name
        
        let url = URL(string: BusinessDetailModel.businessDetail.imageUrl)
        storeProfileImageView.kf.setImage(with: url)
        storeProfileImageView.layer.cornerRadius = 15.0
        storeProfileImageView.clipsToBounds = true
        
        print("this is BusinessDetailModel.businessDetail.photos")
        print(BusinessDetailModel.businessDetail.photos)
        
        for imageUrl in BusinessDetailModel.businessDetail.photos {
            self.downloadImage(urlString: imageUrl)
        }
        
        
        

//        NetworkClient.getBusinessDetail(businessID: self.businessID) {
//            result in
//            switch result {
//            case .success(let detailResponse):
//                print(detailResponse)
//                BusinessDetailModel.businessDetail = detailResponse
//
//                for imageUrl in BusinessDetailModel.businessDetail.photos {
//                    self.downloadImage(urlString: imageUrl)
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
        
    }
    

        
    func downloadImage(urlString: String) {
        let url = URL(string: urlString)!
        let resource = ImageResource(downloadURL: url, cacheKey: "temp")

        KingfisherManager.shared.retrieveImage(with: resource, completionHandler: { result in
            switch result {
            case .success(let result):
//                print("download image has been successfully done")
//                print("Image: \(result.image). Got from: \(result.cacheType)")
                self.imageArray.append(result.image)

                self.imageCollectionView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
     
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Button Actions
    
    @IBAction func callStore(_ sender: Any) {
        if let url = URL(string: "tel://" + BusinessDetailModel.businessDetail.phone) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openStoreWebsite(_ sender: Any) {
        if let url = URL(string: BusinessDetailModel.businessDetail.url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func getDirection(_ sender: Any) {
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
       
        // If the selected store is already in the favorite list, skip the add.
        if favorite {
//            let alertVC = UIAlertController(title: "Remove from Favorites?", message: "", preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .default) {
//
//                let favoriteToDelete = self.stores[]
//
//            }
            return
        }
        
        let store = Store(context: DataController.shared.viewContext)
        
        // Save the business id, name, and profile image
        store.id = BusinessDetailModel.businessDetail.id
        store.name = BusinessDetailModel.businessDetail.name
        
        let imageData = self.storeProfileImageView.image?.pngData()
        store.image = imageData
        
        try? DataController.shared.viewContext.save()
        
        favorite = true
        
        if favorite {
            favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        }
    }
    
    // MARK: Collection View Delegate
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("this is imageArray")
        print(self.imageArray)

        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageViewCell", for: indexPath) as! CafeDetailCollectionViewCell
        cell.cellImageView.image = imageArray[(indexPath as NSIndexPath).row]
        return cell
    }
}
