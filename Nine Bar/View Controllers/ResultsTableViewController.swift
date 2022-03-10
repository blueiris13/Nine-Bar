//
//  ResultsTableViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit
import Kingfisher

class ResultsTableViewController: UITableViewController {
    
    @IBOutlet var resultsTableView: UITableView!
    
    
    func convertMeterToMile(distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters * 0.000621
        return distanceInMiles
    }
    
    // MARK: Tableview Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResultsModel.businesses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessResultsCell", for: indexPath) as! BusinessResultsCell
        
        let businessInfo = SearchResultsModel.businesses[(indexPath as NSIndexPath).row]
        
        
        let url = URL(string: businessInfo.imageUrl)
        cell.businessImageView.kf.setImage(with: url)
        
        cell.businessImageView.layer.cornerRadius = 15.0
        cell.businessImageView.clipsToBounds = true

        cell.businessNameLabel.text = businessInfo.name
        cell.openNowLabel.text = "open now"
        cell.openNowLabel.textColor = .green
        
        
        let distance = self.convertMeterToMile(distanceInMeters: businessInfo.distance)
        let strDistance = String(format: "%.2f", distance) + " mi"
        cell.businessDistanceLabel.text = strDistance
        cell.businessDistanceLabel.textColor = .gray
     
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showBusinessDetail", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
}
