//
//  Store.swift
//  ProductCat
//
//  Created by Hung on 8/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class Store: NSObject {
    public var storeId: Int
    public var name: String
    public var availability: Int
    
    public init(storeId: Int, name: String, availability: Int) {
        self.storeId = storeId
        self.name = name
        self.availability = availability
    }
}
