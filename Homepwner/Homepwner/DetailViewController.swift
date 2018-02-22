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
// declare that DetailViewController conforms to the UINavigationControllerDelegate and the UIImagePickerControllerDelegate protocols
class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
    // check for a camera by calling the method isSourceTypeAvailable(_:)
        let imagePicker = UIImagePickerController()
        // If the device has a camera, take a picture; otherwise,
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        // set the instance of DetailViewController to be the image picker’s delegate in takePicture(_:)
        imagePicker.delegate = self
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    // implement this method to put the image into the UIImageView and then call the method to dismiss the image picker
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // Store the image in the ImageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        // Put that image on the screen in the image view
        imageView.image = image
        // Take image picker off the screen -
        // you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
    
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
    
    // add a property for ImageStore
    var imageStore: ImageStore!
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
        // Get the item key
        let key = item.itemKey
        // If there is an associated image with the item
        // display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
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
