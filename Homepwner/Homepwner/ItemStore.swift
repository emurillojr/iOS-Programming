//
//  ItemStore.swift
//  Homepwner
//
//  Created by user135340 on 2/3/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import UIKit

class ItemStore {
    // declare a property to store the list of Items.
    var allItems = [Item]()
    
    // Implement a new property in ItemStore.swift to store this URL
    let itemArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    // override init() to add the following code.
    init() {
        if let archivedItems =
            NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    
    
    
    
    // implement createItem() to create and return a new Item
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    // implement the designated initializer to add five random items
    //init() {
    //    for _ in 0..<5 {
    //        createItem()
    //    }
    //}
    
    
    
    
    
    
    // implement a new method to remove a specific item
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    // implement a new method for moving rows
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return }
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        // Remove item from array
        allItems.remove(at: fromIndex)
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    
    // implement a new method that calls archiveRootObject(_:toFile:) on the NSKeyedArchiver class
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    
    
}


