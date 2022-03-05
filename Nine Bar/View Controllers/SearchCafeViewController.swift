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
        performSegue(withIdentifier: "completeSearch", sender: nil)
    
    }
    
}
