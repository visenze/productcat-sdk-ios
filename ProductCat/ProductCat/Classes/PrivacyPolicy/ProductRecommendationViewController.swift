//
//  ProductRecommendationViewController.swift
//  ProductCat
//
//  Created by Hung on 13/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class ProductRecommendationViewController: UIViewController {

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
                
        acceptBtn.layer.cornerRadius = ProductCatThemeConstants.cornerRadius
        acceptBtn.backgroundColor = ProductCatThemeConstants.btnPrimaryColor
        
    }
    
}
