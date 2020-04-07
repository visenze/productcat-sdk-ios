//
//  ImageSearchParams.swift
//  ProductCat
//
//  Created by Hung on 7/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class ImageSearchParams: BaseSearchParams {
    
    // MARK: properties
    public var imUrl : String?
    public var imId  : String?
    public var box    : Box?
    
    // image for upload
    public var imgSettings : ImageSettings = ImageSettings()
    public var image : UIImage?
    
    // for resizing
    private var compressedImage : UIImage?
    private var compressedImageData : Data?
    
    public init(country: String, image: UIImage) {
        super.init(country: country)
        
        self.image = image
        imId = nil
        imUrl = nil
    }
    
    public init?(country: String, imId : String){
        super.init(country: country)
        
        if imId.isEmpty {
            print("\(type(of: self)).\(#function)[line:\(#line)] - error: im_id parameter is missing")
            return nil
        }
        
        self.imId = imId
        image = nil
        imUrl = nil
    }
    
    public init?(country: String, imUrl : String){
        super.init(country: country)
        
        if imUrl.isEmpty {
            print("\(type(of: self)).\(#function)[line:\(#line)] - error: im_url parameter is missing")
            return nil
        }
        
        self.imUrl = imUrl
        imId = nil
        image = nil
    }
    
    /// return the compressed/resize image data before uploading
    public func generateCompressImageForUpload() -> Data?
    {
        if let image = image {
        
            let quality = self.imgSettings.quality;
            
            // maxWidth should not larger than 1024 pixels
            let maxWidth = CGFloat( (self.imgSettings.maxWidth > 1024) ? 1024: self.imgSettings.maxWidth );
            
            var actualHeight : CGFloat = image.size.height * image.scale;
            var actualWidth  : CGFloat = image.size.width * image.scale;
            let maxHeight : CGFloat = maxWidth
            var imgRatio : CGFloat = actualWidth/actualHeight;
            let maxRatio : CGFloat = maxWidth/maxHeight;
            
            if (actualHeight > maxHeight || actualWidth > maxWidth) {
                if(imgRatio < maxRatio){
                    //adjust width according to maxHeight
                    imgRatio = maxHeight / actualHeight;
                    actualWidth = imgRatio * actualWidth;
                    actualHeight = maxHeight;
                }
                else if(imgRatio > maxRatio){
                    //adjust height according to maxWidth
                    imgRatio = CGFloat(self.imgSettings.maxWidth) / actualWidth;
                    actualHeight = imgRatio * actualHeight;
                    actualWidth = maxWidth;
                }else{
                    actualHeight = maxHeight;
                    actualWidth = maxWidth;
                }
            }
            
            let rect : CGRect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight);
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0);
            image.draw(in: rect)
            let img = UIGraphicsGetImageFromCurrentImageContext();
            let imageData : Data = img!.jpegData(compressionQuality: CGFloat(quality))!;
            UIGraphicsEndImageContext();
            
            self.compressedImageData = imageData
            self.compressedImage = UIImage(data: imageData)
            
            return imageData
        }
        
        return nil
    }
    
    
    public override func toDict() -> [String: String] {
        var dict = super.toDict()
        
        if let box = box {
            dict["box"] = "\(box.x1),\(box.y1),\(box.x2),\(box.y2)"
        }
        
        if let image = image {
            genResizedBoxForImage(image, &dict)
        }
        else if let imUrl = self.imUrl {
            dict["im_url"] = imUrl
        }
        else if let imgId = self.imId {
            dict["im_id"] = imgId
        }
        else{
            print ("image or im_url or im_id must be provided. Request likely will fail")
        }
        
        return dict;
    }
    
    // if we resized the image before sending to server, we also need to resize the box accordingly
    fileprivate func genResizedBoxForImage(_ image: UIImage, _ dict: inout [String : String]) {
        // add in box parameters
        if let box = box {
            
            if let compressed_image = self.compressedImage {
                
                let scale : CGFloat =
                    (compressed_image.size.height > compressed_image.size.width) ?
                        compressed_image.size.height * compressed_image.scale / (image.size.height * image.scale)
                        : compressed_image.size.width * compressed_image.scale / (image.size.width * image.scale);
                
                let scaleX1 = Int(scale * CGFloat(box.x1) )
                let scaleX2 = Int(scale * CGFloat(box.x2) )
                let scaleY1 = Int(scale * CGFloat(box.y1) )
                let scaleY2 = Int(scale * CGFloat(box.y2) )
                
                dict["box"] = "\(scaleX1),\(scaleY1),\(scaleX2),\(scaleY2)"
                
            }
            
        }
    }
    
}
