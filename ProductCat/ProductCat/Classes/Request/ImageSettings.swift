//
//  ImageSettings.swift
//  ProductCat
//
//  Created by Hung on 7/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import CoreGraphics

/// Set quality if image upload
/// image will be resized before uploadling to server
public class ImageSettings {
    
    /// Default and high quality settings for image upload
    public enum Options {case defaultSetting, highQualitySetting}
    
    public var quality: Float
    public var maxWidth: Float
    
    public convenience init(){
        self.init(setting: Options.defaultSetting)
    }
       
    public init(setting: Options){
        // default setting
        quality = 0.97;
        maxWidth = 512;
        
        // high quality
        if(setting == .highQualitySetting){
            quality = 0.985;
            maxWidth = 1024;
        }
        
    }
    
    public init(size: CGSize, quality: Float) {
        self.quality = quality
        self.maxWidth = Float( (size.height > size.width) ? size.height : size.width);
    }
}
