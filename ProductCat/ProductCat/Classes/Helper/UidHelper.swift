//
//  UidHelper.swift
//  ProductCat
//
//  Created by Hung on 7/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

public class UidHelper: NSObject {
    
    
    /// Internal key for storing uid
    static let ProductCatUidKey = "productcat_uid"
    
    /// retrieve unique device uid and store into userDefaults
    /// this is needed for tracking API to identify various actions
    ///
    /// - returns: unique device uid
    public static func uniqueDeviceUid() -> String {
        let storeUid = SettingHelper.getStringSettingProp(propName: ProductCatUidKey)
        
        if storeUid == nil || storeUid?.count == 0 {
            let deviceId = UIDevice.current.identifierForVendor?.uuidString ;
            
            // store in the setting
            SettingHelper.setSettingProp(propName: ProductCatUidKey, newValue: deviceId!)
            
            return deviceId!
        }
        
        return storeUid!
    }
    
    
    /// Force update the device uid and store in setting
    ///
    /// - parameter newUid: new device uid
    public static func updateStoreDeviceUid(newUid: String) -> Void {
        SettingHelper.setSettingProp(propName: ProductCatUidKey, newValue: newUid)
    }
}
