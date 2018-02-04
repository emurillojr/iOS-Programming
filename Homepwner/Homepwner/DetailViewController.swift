//
//  DetailViewController.swift
//  Homepwner
//
//  Created by user135340 on 2/4/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import UIKit

// declare a new UIViewController subclass named DetailViewController
// implement the UITextFieldDelegate
class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    // Update the method to call endEditing(_:) on the view of DetailViewController
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    
    
    // add a property for an Item instance and override viewWillAppear(_:) to set up the interface
    // add a property observer to the item property that updates the title of the navigationItem
    var item: Item! {
        didSet {
        navigationItem.title = item.name
        }
    }
    
    // Add an instance of NumberFormatter and DateFormatter
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        //valueField.text = "\(item.valueInDollars)"
        //dateLabel.text = "\(item.dateCreated)"
        
        // format the valueInDollars and dateCreated.
        valueField.text =
            numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }
    
    // implement viewWillDisappear(_:)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // dismiss keyboard on back
        // update the implementation of viewWillDisappear(_:) in DetailViewController.swift to call endEditing(_:)
        // Clear first responder
        view.endEditing(true)
        
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    // implement textFieldShouldReturn(_:) to call resignFirstResponder() on the text field that is passed in
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true        
    }

}
