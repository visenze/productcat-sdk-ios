//
//  SimpleResponse.swift
//  ProductCat
//
//  Created by Hung on 8/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

/// Response status from Visenze API. See https://developers.visenze.com/api/#products-summary for more details
public enum ResponseStatus: String {
    case OK = "OK"
    case warning  = "warning"
    case fail = "fail"
    
    var description: String { return self.rawValue }

}

open class SimpleResponse: NSObject {
    //MARK: API data
    
    /// the request status : OK, warning or fail
    public var status: String = ""
    
    /// store list of error messages if request is not successful
    public var error: [String] = []
    
    /// whether API return error
    public var hasError : Bool {
        return !error.isEmpty
    }
    
    /// request ID
    public var reqid: String = ""
    
    /// MARK: initializer
    public init?(data: Data) {
        super.init()
        
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
            
            self.parseJson(json)
        
        }
        catch {
            print("\(type(of: self)).\(#function)[line:\(#line)] - error: Json response might be invalid. Error during processing:")
            print ("\(error)\n")
            return nil
        }

    }
    
    public func parseJson(_ json: [String : Any]) {
       self.status = json["status"] as! String
       
       if let errorArr = json["error"] as? [String] {
           self.error = errorArr
       }
        
        if let requestId = json["reqid"] as? String {
            self.reqid = requestId
        }
    
   }
    
    
}
