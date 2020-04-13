//
//  UIColorExtension.swift
//  ProductCat
//
//  Created by Hung on 6/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

// MARK: - extension for UIColor to generate hex string
extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
           let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
           let scanner = Scanner(string: hexString)
           if (hexString.hasPrefix("#")) {
               scanner.scanLocation = 1
           }
           var color: UInt32 = 0
           scanner.scanHexInt32(&color)
           let mask = 0x000000FF
           let r = Int(color >> 16) & mask
           let g = Int(color >> 8) & mask
           let b = Int(color) & mask
           let red   = CGFloat(r) / 255.0
           let green = CGFloat(g) / 255.0
           let blue  = CGFloat(b) / 255.0
           self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    /// return hex string for UIColor in form of XXXXXX (6 characters without the #)
    ///
    /// - returns: 6 characters hex string
    public func hexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
    
        return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
}

