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
    @IBAction func buttonTapped(_ sender: UIButton) {
        // add a print() statement to the buttonTapped(_:) method to confirm that the method is called in response to a button tap.
        print("Called buttonTapped(_:)")
    }

}

