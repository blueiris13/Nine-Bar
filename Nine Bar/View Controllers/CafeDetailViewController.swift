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
    
    
    var businessID: String = ""
    
    var timer = Timer()
    var counter = 0
    
    var imageArray = [UIImage]()
    
    var imgArray = [UIImage(named: "hello"), UIImage(named: "hello"), UIImage(named: "hello")]
    
    
    override func viewDidLoad() {
            
        for imageUrl in BusinessDetailModel.businessDetail.photos {
            self.downloadImage(urlString: imageUrl)
        }
        print("hello")
        print(self.imageArray)
        
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
            
//            print(self.imageArray)
//            if self.imgArray.count > 0 {
//                self.pageView.numberOfPages = self.imgArray.count
//                self.pageView.currentPage = 0
//                DispatchQueue.main.async {
//                    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.slidingImage), userInfo: nil, repeats: true)
//                print("hello?")
//                }
//            self.imageCollectionView.reloadData()
//
//            }
//        }
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
    
    @objc func slidingImage(){
        
        if counter < imgArray.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.imageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item:counter, section: 0)
            self.imageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }

    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
