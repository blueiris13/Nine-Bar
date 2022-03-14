//
//  FavoritesListViewController.swift
//  Nine Bar
//
//  Created by Hyun Kim
//

import UIKit
import CoreData

class FavoritesListViewController: UITableViewController {
    
    @IBOutlet var favoritesTableView: UITableView!
    var stores = [Store]()
    
    var store: Store!
    
    override func viewDidLoad() {
        let storeFetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        if let result = try? DataController.shared.viewContext.fetch(storeFetchRequest) {
            stores = result
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesCell
        
        if self.stores.count != 0 {
            let store = self.stores[(indexPath as NSIndexPath).row]
            cell.businessNameLabel.text = store.name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}
