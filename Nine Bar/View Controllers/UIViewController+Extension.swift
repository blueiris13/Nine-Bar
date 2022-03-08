//
//  UIViewController+Extension.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import Foundation
import UIKit

extension UIViewController {
    
    @IBAction func goBackToSearch(_ sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
    
    func showFailureMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
