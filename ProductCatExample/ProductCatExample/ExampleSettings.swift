//
//  ExampleSettings.swift
//  ProductCatExample
//
//  Created by Hung on 17/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

class ExampleSettings: NSObject {
    private static let countryKey : String = "country"
    private static let resultPerPageKey : String = "resultPerPage"
    private static let preferBrowserKey : String = "preferBrowser"
    
    
    public static let RESULTS_PER_PAGE_LIST : [Int] = [10, 20, 30, 50, 100]
    public static let builtinBrowser = "Builtin"
    
    public static let BROWSERS_SCHEMES = [
        builtinBrowser : "",
        "Default" : "http://",
        "Google Chrome" : "googlechrome://",
        "Dolphin" : "dolphin://",
        "UC Browser" : "ucbrowser://",
    ]
    
    public static let BROWSERS = [builtinBrowser, "Default" , "Google Chrome", "Dolphin", "UC Browser"]
    
    public class func setPreferBrowser(_ browser: String) {
        UserDefaults.standard.set(browser, forKey: preferBrowserKey)
    }
    
    public class func getPrefBrowser() -> String {
        let result =  UserDefaults.standard.string(forKey: preferBrowserKey)
        if result == nil || result?.count == 0 {
            return builtinBrowser
        }
        
        return result!
    }
    
    public class func setCountry(_ countryCode: String) {
        UserDefaults.standard.set(countryCode, forKey: countryKey)
    }
    
    public class func setResultPerPage(_ resultPerPage: Int) {
        UserDefaults.standard.set(resultPerPage, forKey: resultPerPageKey)
    }
    
    public class func getResultPerPage() -> Int {
        var result = UserDefaults.standard.integer(forKey: resultPerPageKey)
        if (result < 1) {
            result = 10
        }
        
        return result
    }
    
    public class func getCountry() -> String? {
        let result =  UserDefaults.standard.string(forKey: countryKey)
        if result == nil || result?.count == 0 {
            
            // get country code from locale
            if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
                if countryCode.count == 2 {
                    return countryCode
                }
            }
            
            return nil
        }
        
        return result
    }
}
