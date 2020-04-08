//
//  TagGroup.swift
//  ProductCat
//
//  Created by Hung on 8/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class TagGroup: NSObject {

    public var tagGroup: String
    public var tags : [Tag] = []
    
    public init(tagGroup: String) {
        self.tagGroup = tagGroup
    }
}
