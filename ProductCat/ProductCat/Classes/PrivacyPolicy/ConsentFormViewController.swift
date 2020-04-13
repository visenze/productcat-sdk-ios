//
//  ConsentFormViewController.swift
//  ProductCat
//
//  Created by Hung on 13/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class ConsentFormViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var textViewContainer: UIView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    
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
        
        descTextView.delegate = self
        
        acceptBtn.layer.cornerRadius = 3.0
        acceptBtn.backgroundColor = UIColor(hexString: "#283d78")
        
    }
    
    open func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
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
