//
//  SettingHelper.swift
//  ProductCat
//
//  Created by Hung on 6/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import Foundation

// store settings
public class SettingHelper {
    private static let ACCEPT_VISENZE_TERMS = "accept_vs_terms"
    private static let ACCEPT_VISENZE_ADS = "accept_vs_ads"
    
    
    public static func isAcceptedVisenzeAds() -> Bool? {
        return SettingHelper.getBoolSettingProp(propName: ACCEPT_VISENZE_ADS)
    }
    
    public static func setAcceptedViSenzeAds(_ newValue: Bool) {
        self.setBoolSettingProp(propName: ACCEPT_VISENZE_ADS, newValue: newValue)
    }
    
    public static func isAcceptedVisenzeTerms() -> Bool? {
        return SettingHelper.getBoolSettingProp(propName: ACCEPT_VISENZE_TERMS)
    }
    
    public static func setAcceptedViSenzeTerms(_ newValue: Bool) {
        self.setBoolSettingProp(propName: ACCEPT_VISENZE_TERMS, newValue: newValue)
    }
    
    public static func setBoolSettingProp(propName: String , newValue: Bool) -> Void {
        let userDefault = UserDefaults.standard
        userDefault.set(newValue, forKey: propName)
    }
    
    public static func getBoolSettingProp (propName: String) -> Bool? {
       let userDefault = UserDefaults.standard
       return userDefault.bool(forKey: propName)
    }
    
    /// Set a property , store in userDefault
    ///
    /// - parameter propName: property name
    /// - parameter newValue: new value for property
    public static func setSettingProp(propName: String , newValue: Any?) -> Void {
        let userDefault = UserDefaults.standard
        userDefault.set(newValue, forKey: propName)
    }
    
    
    /// retrieve setting in userdefault as String
    ///
    /// - parameter propName: name of property
    ///
    /// - returns: value as String?
    public static func getStringSettingProp (propName: String) -> String? {
        let userDefault = UserDefaults.standard
        return userDefault.string(forKey: propName)
    }
}
