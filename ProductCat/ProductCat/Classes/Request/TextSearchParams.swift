//
//  TextSearchParams.swift
//  ProductCat
//
//  Created by Hung on 7/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class TextSearchParams: BaseSearchParams {

    // query
    public var q  : String
    
    public init(country: String, q : String){
        self.q = q.trimmingCharacters(in: .whitespaces)
        super.init(country: country)
    }
    
    public override func toDict() -> [String: String] {
        var dict = super.toDict()
        
        dict["q"] = self.q
        
        return dict;
    }
    
}
