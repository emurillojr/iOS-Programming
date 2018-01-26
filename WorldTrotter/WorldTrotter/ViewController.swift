//
//  ViewController.swift
//  WorldTrotter
//
//  Created by user135340 on 1/25/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // created instance of UIView frame with background color of blue
        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
        let firstView = UIView(frame: firstFrame)
        firstView.backgroundColor = UIColor.blue
        view.addSubview(firstView)
        
        // created another instance of UIView frame with background color of green
        let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 50)
        let secondView = UIView(frame: secondFrame)
        secondView.backgroundColor = UIColor.green
        //view.addSubview(secondView)
        // adjust view hierarchy
        firstView.addSubview(secondView)
    }


}

