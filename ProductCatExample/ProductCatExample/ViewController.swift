//
//  ViewController.swift
//  ProductCatExample
//
//  Created by Hung on 13/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit
import ProductCat

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showConsentForm(_ sender: Any) {
        ProductCat.sharedInstance.showConsentForm(nil)
        
    }
    
    
    @IBAction func testBtnClick(_ sender: Any) {
        let imgSearchParams = ImageSearchParams(
            country: ProductCat.sharedInstance.client!.country ,
            image: UIImage(ciImage: CIImage(color: .red))
        )
        
        ProductCat.sharedInstance.imageSearch(params: imgSearchParams,
                                              successHandler: {
                              (data : ProductSummaryResponse?) -> Void in
                                  // Do something when request succeeds
                                  // preview by calling : dump(data)
                                  // check data.hasError and data.error for any errors return by ViSenze server
                                  dump(data)
                                                
                                    
                          },
                         failureHandler: {
                              (err) -> Void in
                              // Do something when request fails e.g. due to network error
                            print ("error: \(err)")
                          })
        
    }
    
}

