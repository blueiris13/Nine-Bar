//
//  CafeDetailViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit

class CafeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        print("cafeDetailVeiwcontroller")
    }
}
