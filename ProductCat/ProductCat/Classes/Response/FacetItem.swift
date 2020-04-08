//
//  FacetItem.swift
//  ProductCat
//
//  Created by Hung on 8/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class FacetItem: NSObject {
    public var value : String
    public var count : Int = 0
    public var name: String?
    public var id: Int?
    
    public init(value: String) {
        self.value = value
    }
    
    public init(value: String, count: Int) {
        self.value = value
        self.count = count
    }
}
