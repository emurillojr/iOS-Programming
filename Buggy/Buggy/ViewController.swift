//
//  ViewController.swift
//  Buggy
//
//  Created by user135340 on 2/12/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // implement an action method for the button to trigger
    //@IBAction func buttonTapped(_ sender: UIButton) {
    //@IBAction func switchToggled(_ sender: UISwitch) {
    //@IBAction func buttonTapped(_ sender: UISwitch) {
    @IBAction func buttonTaped(_ sender: UIButton) {
    
    
    // add a print() statement to the buttonTapped(_:) method to confirm that the method is called in response to a button tap.
        //print("Called buttonTapped(_:)")
        
        //To illustrate the use of these literal expressions
        print("Method: \(#function) in file: \(#file) line: \(#line) called.")
        
        badMethod()
        
        // Log sender:
        //print("sender: \(sender)")
        
        // Log the control state:
        //print("Is control on? \(sender.isOn)")
    }
    
    func badMethod() {
        let array = NSMutableArray()
        for i in 0..<10 {
            array.insert(i, at: i)
        }
        // Go one step too far emptying the array (notice the range change):
        for _ in 0..<10 {
            //array.remove(at: 0)   // book error
            array.remove(0)
        }
    }
}

