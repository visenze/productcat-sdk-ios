//
//  Facet.swift
//  ProductCat
//
//  Created by Hung on 8/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class Facet: NSObject {
    /// facet field name
    public var key   : String
    
    /// facet field items for string facets fields
    public var items : [FacetItem] = []
    
    // for numeric facet, a range will be return instead
    public var min: Float? = nil
    
    // for numeric facet, a range with min, max will be returned insted
    public var max: Float? = nil
    
    public init(key: String) {
        self.key = key
    }
    
    public init(key: String, items:  [FacetItem] ) {
        self.key = key
        self.items = items
    }
}
