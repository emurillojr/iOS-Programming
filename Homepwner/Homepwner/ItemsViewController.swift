//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by user135340 on 2/3/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {  // implement a subclass of UITableViewController for Homepwner
    
    // add a property for an ItemStore
    var itemStore: ItemStore!
    
    // implement tableView(_:numberOfRowsInSection:).
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    // implement tableView(_:cellForRowAt:) so that the nth row displays the nth entry in the allItems array
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // updated to update tableView(_:cellForRowAt:) to reuse cells.
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                 for: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        return cell
        
    }
    
    // override viewDidLoad() to update the table view content inset
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    
    
    
    
    
}
