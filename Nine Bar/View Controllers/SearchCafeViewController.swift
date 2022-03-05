//
//  SearchCafeViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit

class SearchCafeViewController: UIViewController {

    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBAction func tabSearchButton(_ sender: Any) {
        NetworkClient.getSearchResults(latitude: 37.786882, longitude: -122.399972) {
            result in
            switch result {
            case .success(let searchResponse):
                print(searchResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        performSegue(withIdentifier: "completeSearch", sender: nil)
    
    }
    
}
