//
//  ItemCell.swift
//  Homepwner
//
//  Created by user135340 on 2/3/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import UIKit

// define ItemCell as a UITableViewCell subclass
class ItemCell: UITableViewCell {
    
    // connect outlets on ItemCell for each of its subviews
    // add three properties for the outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    // override awakeFromNib() to have the labels automatically adjust
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
    
    
}
