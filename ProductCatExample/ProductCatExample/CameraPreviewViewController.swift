//
//  CameraPreviewViewController.swift
//  ProductCatExample
//
//  Created by Hung on 17/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit
import ProductCat
import ALCameraViewController
import KRProgressHUD
import SafariServices

class CameraPreviewViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        if let img = self.imgView.image {
            
            self.showHud()
            
            let country = ExampleSettings.getCountry() ?? "SG"
            
            let imgSearchParams = ImageSearchParams(
                country: country ,
                image: img
            )
            
            imgSearchParams.limit = ExampleSettings.getResultPerPage()
            
            if country == "CN" {
                ProductCat.sharedInstance.client?.baseUrl = ProductCatClient.DEFAULT_CN_ENDPOINT
            } else {
                ProductCat.sharedInstance.client?.baseUrl = ProductCatClient.DEFAULT_ENDPOINT
            }
            
            ProductCat.sharedInstance.imageSearchResultPage(params: imgSearchParams,
                                                  successHandler: {
                                  (data : ProductSummaryResponse?) -> Void in
                                      // Do something when request succeeds
                                      // preview by calling : dump(data)
                                      // check data.hasError and data.error for any errors return by ViSenze server
                                        dump(data)
                                                    
                                        if let data = data {
                                            if data.hasError {
                                                let errMsgs =  data.error.joined(separator: ",")
                                                
                                                DispatchQueue.main.async {
                                                    // error message from server e.g. invalid parameter
                                                    self.alert(message: "API error: \(errMsgs)", title: "Error")
                                                    self.dismissHud()
                                                }
                                                
                                                
                                                return
                                            }
                                            
                                            // perform segue here
                                                
                                            // for debuging, dump all data from server
                                                
                                            DispatchQueue.main.async {
                                                // open browser
                                                if let searchResultsUrl = data.srpUrl, let url = URL(string: searchResultsUrl) {
                                                    
                                                    self.openBrowser(searchResultsUrl, url)
                                                    
                                                } else {
                                                    self.alert(message: "Search Results URL is missing!", title: "Error")
                                                }
                                            }
                                            
                                        }
                                        
                                        self.dismissHud()
                                                    
                                        
                              },
                             failureHandler: {
                                  (err) -> Void in
                                    // Do something when request fails e.g. due to network error
                                    print ("error: \(err)")
                                
                                    DispatchQueue.main.async {
                                        // Do something when request fails e.g. due to network error
                                        self.alert(message: "An error has occured: \(err)", title: "Error")
                                        self.dismissHud()
                                    }
                              })
        }
    }
    
    fileprivate func openBrowser(_ searchResultsUrl: String, _ url: URL) {
            let preferBrowser = ExampleSettings.getPrefBrowser()
           
            if preferBrowser == ExampleSettings.builtinBrowser {
               let vc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
               vc.delegate = self
               self.present(vc, animated: true)
               return
            }
        
            // get the custom scheme
            if let scheme = ExampleSettings.BROWSERS_SCHEMES[preferBrowser] {
                var newSchemeURl = searchResultsUrl.replacingOccurrences(of: "https://", with: scheme)
                newSchemeURl = searchResultsUrl.replacingOccurrences(of: "http://", with: scheme)
                let schemeUrl = NSURL(string: newSchemeURl) as! URL
                
                if UIApplication.shared.canOpenURL(schemeUrl) {
                    UIApplication.shared.openURL(schemeUrl)
                } else {
                    alert(message: "This browser might not be available. Please download from AppStore.", title: "Error")
                }
                
            }
          
       }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
    // MARK: hud methods
    private func showHud(){
        KRProgressHUD.show()
    }
    
    private func dismissHud() {
        KRProgressHUD.dismiss()
    }
    
    // MARK: photo methods
    @IBAction func takePhoto(_ sender: Any) {
        
        let cameraViewController =  CameraViewController { [weak self] image, asset in
            
            self?.imgView.image = image
            self?.dismiss(animated: true, completion: nil)
        }
        
        cameraViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        cameraViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        present(cameraViewController, animated: true, completion: nil)
    }
    
    @IBAction func openGallery(_ sender: Any) {
        let cropParam = CroppingParameters()
        let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: cropParam) { image, asset in
            
            self.imgView.image = image
            self.dismiss(animated: true, completion: nil)
        }
        
        libraryViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        libraryViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        present(libraryViewController, animated: true, completion: nil)
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

}
