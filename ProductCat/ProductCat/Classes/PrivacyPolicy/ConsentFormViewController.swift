//
//  ConsentFormViewController.swift
//  ProductCat
//
//  Created by Hung on 13/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

public protocol ConsentFormDelegate: class {
    func acceptTerms()
    func declineTerms()
    func agreeRecommendation()
    func disagreeRecommendation()
}

open class ConsentFormViewController: UIViewController, UITextViewDelegate, ProductRecommendationDelegate {

    weak var delegate: ConsentFormDelegate?
    
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var textViewContainer: UIView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textViewContainer.layer.cornerRadius = ProductCatThemeConstants.cornerRadius
        
        descTextView.textContainerInset = .zero
        descTextView.textContainer.lineFragmentPadding = .zero
        
        descTextView.addHyperLinksToText(originalText: descTextView.text!, hyperLinks: [
            "Privacy policy" :"https://shopping.visenze.com/privacy-policy",
            "Terms of use" : "https://shopping.visenze.com/terms-of-use"
        ])
        
        descTextView.delegate = self
        
        acceptBtn.layer.cornerRadius = ProductCatThemeConstants.cornerRadius
        acceptBtn.backgroundColor = ProductCatThemeConstants.btnPrimaryColor
        
    }
    
    open func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    

    @IBAction func declineClick(_ sender: Any) {
        SettingHelper.setAcceptedViSenzeTerms(false)
        
        self.dismiss(animated: true) {
            self.delegate?.declineTerms()
        }
        
    }
    
    
    @IBAction func acceptClick(_ sender: Any) {
        
        // move to product recommendation
        self.delegate?.acceptTerms()
        SettingHelper.setAcceptedViSenzeTerms(true)
        self.view.isHidden = true
    }
    
    open func agreeRecommendation() {
        self.dismiss(animated: true) {
            self.delegate?.agreeRecommendation()
        }
    }
    
    open func disagreeRecommendation() {
        self.dismiss(animated: true) {
            self.delegate?.disagreeRecommendation()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRec" {
            let recController = segue.destination as! ProductRecommendationViewController
            recController.delegate = self
            
        }
    }
    

}
