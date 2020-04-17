//
//  ViewController.swift
//  ProductCatExample
//
//  Created by Hung on 13/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit
import ProductCat

// Home page
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showConsentForm(_ sender: Any) {
        ProductCat.sharedInstance.showConsentForm(nil)
    }
    
}

