//
//  CafeDetailViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit
import Kingfisher

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
    
    
    override func viewDidLoad() {
        
        
        
        
        for imageUrl in BusinessDetailModel.businessDetail.photos {
            self.downloadImage(urlString: imageUrl)
        }
        
        businessName.text = BusinessDetailModel.businessDetail.name
        
        let url = URL(string: BusinessDetailModel.businessDetail.imageUrl)
        storeProfileImageView.kf.setImage(with: url)
        storeProfileImageView.layer.cornerRadius = 15.0
        storeProfileImageView.clipsToBounds = true
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageCollectionView.reloadData()
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
                print(self.imageArray)
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
        let store = Store(context: DataController.shared.viewContext)
        store.name = BusinessDetailModel.businessDetail.name
        try? DataController.shared.viewContext.save()
        
        favorite = true
        
        if favorite {
            favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        }
        
    }
    
    // MARK: Collection View Delegate
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("hello???")

        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageViewCell", for: indexPath) as! CafeDetailCollectionViewCell
        cell.cellImageView.image = imgArray[(indexPath as NSIndexPath).row]
        return cell
    }
}
