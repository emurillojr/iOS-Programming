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
    
    // stub out two methods in the implementation
    @IBAction func addNewItem(_ sender: UIButton) {
        // implement addNewItem(_:)
        
        // Make a new index path for the 0th section, last row
        //let lastRow = tableView.numberOfRows(inSection: 0)
        //let indexPath = IndexPath(row: lastRow, section: 0)
        // Insert this new row into the table
        //tableView.insertRows(at: [indexPath], with: .automatic)
        
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        // Figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        
    }
    @IBAction func toggleEditingMode(_ sender: UIButton) {
      // implement toggleEditingMode(_:)
     
        // If you are currently in editing mode...
        if isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            // Enter editing mode
            setEditing(true, animated: true)
        }
    
    }
    
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
        
        // updated to update tableView(_:cellForRowAt:) to reuse cells
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
    
    // implement this method to have the ItemStore remove the right object and confirm the row deletion by calling the method deleteRows(at:with:) on the table view
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            // to ask the user to confirm or cancel the deletion of an item
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            
            // Add the necessary actions to the action sheet in tableView(_:commit:forRowAt:)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                             handler: { (action) -> Void in
            // Remove the item from the store
            self.itemStore.removeItem(item)
            // Also remove that row from the table view with an animation
            self.tableView.deleteRows(at: [indexPath], with: .automatic) })
            ac.addAction(deleteAction)
            // Present the alert controller
            present(ac, animated: true, completion: nil)
            
        }
    }
    
    // implement tableView(_:moveRowAt:to:) to update the store
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            // Update the model
        to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
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
