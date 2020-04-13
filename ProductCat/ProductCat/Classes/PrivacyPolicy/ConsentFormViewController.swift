//
//  ConsentFormViewController.swift
//  ProductCat
//
//  Created by Hung on 13/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class ConsentFormViewController: UIViewController {

    @IBOutlet weak var descTextView: UITextView!
    
    @IBOutlet weak var textViewContainer: UIView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textViewContainer.layer.cornerRadius = 3.0
        
        descTextView.textContainerInset = .zero
        descTextView.textContainer.lineFragmentPadding = .zero
        
        descTextView.addHyperLinksToText(originalText: descTextView.text!, hyperLinks: [
            "Privacy policy" :"https://shopping.visenze.com/privacy-policy",
            "Terms of use" : "https://shopping.visenze.com/terms-of-use"
        ])
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
