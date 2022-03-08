//
//  ResultsTableViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    @IBOutlet var resultsTableView: UITableView!
    
    // MARK: Tableview Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResultsModel.businesses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessResultsCell", for: indexPath)
        
        let businessInfo = SearchResultsModel.businesses[(indexPath as NSIndexPath).row]
        let name = businessInfo.name
        
        cell.textLabel?.text = name
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showBusinessDetail", sender: nil)
    }
    
    
}
