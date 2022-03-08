//
//  FavoritesListViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit

class FavoritesListViewController: UITableViewController {
    
    @IBOutlet var favoritesTableView: UITableView!
    var tempArray = [1,2,3]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        return cell
    }
}
