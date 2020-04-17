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

class CameraPreviewViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchClicked(_ sender: Any) {
    
    }
    
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
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
