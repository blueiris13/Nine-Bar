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
    
    var selectedBusinessID: String!
    
    let resultTableCellIdentifier: String = "businessResultsCell"
    
    func convertMeterToMile(distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters * 0.000621
        return distanceInMiles
    }
    
    // MARK: Tableview Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResultsModel.businesses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.resultTableCellIdentifier, for: indexPath) as! BusinessResultsCell
        
        let businessInfo = SearchResultsModel.businesses[(indexPath as NSIndexPath).row]
        
        cell.businessImageView.image = UIImage(named: "placeholder image")
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
        
        let businessInfo = SearchResultsModel.businesses[(indexPath as NSIndexPath).row]
        self.selectedBusinessID = businessInfo.id
        
        NetworkClient.getBusinessDetail(businessID: self.selectedBusinessID) {
                result in
            switch result {
            case .success(let detailResponse):
                BusinessDetailModel.businessDetail = detailResponse
                self.performSegue(withIdentifier: "showBusinessDetail", sender: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        resultsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}
