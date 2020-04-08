//
//  Tag.swift
//  ProductCat
//
//  Created by Hung on 8/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class Tag: NSObject {
    public var tagId : String
    public var tag: String
    public var score: Float
    
    public init(tagId: String, tag: String, score: Float) {
        self.tagId = tagId
        self.score = score
        self.tag = tag
    }
    
}
