//
//  ProductSummary.swift
//  ProductCat
//
//  Created by Hung on 8/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class ProductSummary: NSObject {
    public var pgid  : String = ""
    public var mainImage  : String = ""
    public var pid  : String = ""
    public var images: [String] = []
    public var title: String = ""
    public var desc: String = ""
    public var brand: String = ""
    public var brandId: String = ""
    public var country: String = ""
    public var productUrl: String = ""
    
    public var minPrice: Float = 0
    public var maxPrice: Float = 0
    public var priceUnit: String = ""
    public var priceSymbol: String = ""
    
    public var originalMinPrice: Float = 0
    public var originalMaxPrice: Float = 0
    public var originalPriceUnit: String = ""
    
    public var minOPrice: Float = 0
    public var maxOPrice: Float = 0
    public var originalMinOPrice: Float = 0
    public var originalMaxOPrice: Float = 0
    
    public var attrs: [String: Any] = [:]
    public var stores: [Store] = []

}
