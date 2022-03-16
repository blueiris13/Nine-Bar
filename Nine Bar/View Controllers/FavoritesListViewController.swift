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
    
//    var store: Store!
    

    
    override func viewDidLoad() {
        viewLoadSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewLoadSetUp()
        self.favoritesTableView.reloadData()
        
    }
    
    fileprivate func viewLoadSetUp() {
        let storeFetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        if let result = try? DataController.shared.viewContext.fetch(storeFetchRequest) {
            stores = result
        }
    }
    
    func deleteStore(at: IndexPath) {
        let storeToDelete = stores[(at).row]
        DataController.shared.viewContext.delete(storeToDelete)
        try? DataController.shared.viewContext.save()
        
        stores.remove(at: at.row)
        favoritesTableView.reloadData()
    }
    
    // MARK: Table View Delegate
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesCell
        
        if self.stores.count != 0 {
            let store = self.stores[(indexPath as NSIndexPath).row]
            cell.businessNameLabel.text = store.name
            cell.businessImageView.image = UIImage(data: store.image!)
            
            cell.businessImageView.layer.cornerRadius = 15.0
            cell.businessImageView.clipsToBounds = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let store = self.stores[(indexPath as NSIndexPath).row]
        
        NetworkClient.getBusinessDetail(businessID: store.id!) {
            result in
            switch result {
            case .success(let detailResponse):
                BusinessDetailModel.businessDetail = detailResponse
                self.performSegue(withIdentifier: "showBusinessDetail", sender: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        favoritesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteStore(at: indexPath)
        default: ()
        }
    }
}
