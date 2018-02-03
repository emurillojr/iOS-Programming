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
    
    // implement createItem() to create and return a new Item
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    // implement the designated initializer to add five random items
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    
}


