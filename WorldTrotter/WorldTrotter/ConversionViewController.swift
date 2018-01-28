//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by user135340 on 1/28/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController {
    
    // create an outlet to the Celsius text label and create an action for the text field to call when the text changes
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField! // outlet for background view is tapped
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        //celsiusLabel.text = textField.text
        // to display “???” if the text field is empty.
        if let text = textField.text, !text.isEmpty {
            celsiusLabel.text = text
        } else {
            celsiusLabel.text = "???"
        }
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    
    
}
