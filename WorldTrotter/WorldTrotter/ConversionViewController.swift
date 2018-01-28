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
    // store the current Fahrenheit value, optional measurement for temperature
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        // Add a property observer to fahrenheitValue that gets called after the property value changes.
        didSet {
            updateCelsiusLabel()
        }
    }
    
    // add a computed property for the Celsius value. This value will be computed based on the Fahrenheit value.
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil }
    }
    
    @IBOutlet var textField: UITextField! // outlet for background view is tapped
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        //celsiusLabel.text = textField.text
        // to display “???” if the text field is empty.
        //if let text = textField.text, !text.isEmpty {
        //    celsiusLabel.text = text
        //} else {
        //    celsiusLabel.text = "???"
        //}
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    // updates the celsius label
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            //celsiusLabel.text = "\(celsiusValue.value)"
            // modified updateCelsiusLabel() to use this formatter
            celsiusLabel.text =
                numberFormatter.string(from: NSNumber(value: celsiusValue.value))        } else {
            celsiusLabel.text = "???"
        }
    }
    
    // update celsiusLabel when application runs insead of showing 100
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
    }
    
    // Created a constant number formatter
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    
    
}
