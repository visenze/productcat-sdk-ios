//
//  ProductType.swift
//  ProductCat
//
//  Created by Hung on 8/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class ProductType: NSObject {
    public var box   : Box
    public var score : Float
    public var type  : String
    public var attributes : [String: Any] = [:]
    
    public init(box: Box, score: Float, type: String) {
        self.box = box
        self.score = score
        self.type = type
    }
}
