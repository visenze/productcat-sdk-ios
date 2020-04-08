//
//  ProductSummaryResponse.swift
//  ProductCat
//
//  Created by Hung on 7/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

public class ProductSummaryResponse: SimpleResponse {
    
    /// the unique ID for uploaded image, only available for image search
    public var imId: String?
    
    /// The list of products in search results
    public var result: [ProductSummary] = []
    
    /// for automatic object detection, list of products found on query image with box
    public var productTypes: [ProductType] = []
    
    /// facet results
    public var facets : [Facet] = []
    
    /// search result page url, only applicable for Search Results Page API
    public var srpUrl: String?
    
    /// Recognition results
    public var recognizeResult: [TagGroup] = []
    
    public override func parseJson(_ json: [String : Any]) {
        super.parseJson(json)
        
        self.imId  = json["im_id"] as? String
        self.srpUrl = json["srp_url"] as? String
        
        if let resultJson = json["result"] as? [Any] {
           self.result = self.parseResults(resultJson)
        }

        // extract product types
        if let pTypesJson = json["product_types"] as? [Any] {
           self.productTypes = self.parseProductTypes(pTypesJson)
        }

        if let facetListJson = json["facets"] as? [Any] {
           self.facets = self.parseFacets(facetListJson)
        }
        
        // recognition
        if let recJson = json["recognize_result"] as? [Any] {
           self.recognizeResult = self.parseRecResults(recJson)
        }
    }
    
    // MARK: parsing json methods
    
    public func parseResults(_ arr: [Any]) -> [ProductSummary]{
        var results = [ProductSummary]()
        
        for jsonItem in arr {
            if let dict = jsonItem as? [String:Any] {
                let item = ProductSummary()
                
                item.pid = dict["pid"] as! String
                item.pgid = dict["pgid"] as! String
                item.mainImage = dict["main_image"] as! String
                if let images = dict["images"] as? [String] {
                    item.images = images
                }
                
                item.title = dict["title"] as! String
                item.desc = (dict["desc"] as? String) ?? ""
                item.productUrl = dict["product_url"] as! String
                item.brand = dict["brand"] as? String ?? ""
                
                item.brandId = dict["brand_id"] as? String ?? ""
                item.country = dict["country"] as! String
                item.minPrice = parseFloat(dict, "min_price")
                item.maxPrice = parseFloat(dict, "max_price")
                item.minOPrice = parseFloat(dict, "min_o_price")
                item.maxOPrice = parseFloat(dict, "max_o_price")
                item.priceUnit = dict["price_unit"] as! String
                item.priceSymbol = dict["price_symbol"] as? String ?? ""
                
                item.originalMinPrice = parseFloat(dict, "original_min_price")
                item.originalMaxPrice = parseFloat(dict, "original_max_price")
                item.originalMinOPrice = parseFloat(dict, "original_min_o_price")
                item.originalMaxOPrice = parseFloat(dict, "original_max_o_price")
                item.originalPriceUnit = dict["original_price_unit"] as? String ?? ""
                item.attrs = dict["attrs"] as? [String: Any] ?? [:]
                
                // parse stores
                if let storeArr = dict["stores"] as? [Any] {
                    var stores : [Store] = []
                    for storeJson in storeArr {
                        if let storeObj = storeJson as? [String: Any] {
                            let storeId = storeObj["store_id"] as? Int ?? 0
                            let name = storeObj["name"] as? String ?? ""
                            let availability = storeObj["availability"] as? Int ?? 1
                            let store = Store(storeId: storeId, name: name, availability: availability)
                            stores.append(store)
                        }
                    }
                    
                    item.stores = stores
                }
                
                results.append(item)
            }
        }
        
        return results
    }
    
    public func parseRecResults(_ arr: [Any]) -> [TagGroup]{
        var results = [TagGroup]()
        for jsonItem in arr {
            if let dict = jsonItem as? [String:Any] {
                let tagGroup = (dict["tag_group"] as? String) ?? ""
                let item = TagGroup(tagGroup: tagGroup)
                var tags : [Tag] = []
               
                if let tagArr = dict["tags"] as? [Any] {
                    for tagObjJson in tagArr {
                        if let tagObj = tagObjJson as? [String: Any] {
                            let tagId = tagObj["tag_id"] as! String
                            let tag = tagObj["tag"] as! String
                            let score = self.parseFloat(tagObj, "score")
                            tags.append(Tag(tagId: tagId, tag: tag, score: score))
                        }
                    }
                }
                
                item.tags = tags
                
                results.append(item)
            }
        }
        
        return results
    }
    
    public func parseFacets(_ arr: [Any]) -> [Facet]{
        var results = [Facet]()
        
        for jsonItem in arr {
            if let dict = jsonItem as? [String:Any] {
                let key = dict["key"] as! String
                let item = Facet(key: key)
                
                // string facet (store or brand)
                if let itemArr = dict["items"] as? [Any] {
                    var facetItems : [FacetItem] = []
                    
                    for itemDict in itemArr {
                        
                        if let itemDict = itemDict as? [String:Any] {
                            let val = itemDict["value"] as! String
                            let count = (itemDict["count"] as? Int) ?? 0
                            let facetItem = FacetItem(value: val, count: count)
                            facetItem.name = itemDict["name"] as? String
                            facetItem.id = itemDict["id"] as? Int
                            
                            facetItems.append(facetItem)
                        }
                    }
                    item.items = facetItems
                }
                
                // numeric facet (price)
                if let range = dict["range"] as? [String: Any] {
                    item.min = self.parseFloat(range, "min")
                    item.max = self.parseFloat(range, "max")
                }
                
                results.append(item)
            }
        }
        
        return results
    }
    
    
    public func parseProductTypes(_ arr: [Any]) -> [ProductType]{
        var results = [ProductType]()
        for jsonItem in arr {
            if let dict = jsonItem as? [String:Any] {
                let type = (dict["type"] as? String) ?? ""
                let score = parseFloat(dict, "score")
                
                let boxArr = (dict["box"] as? [Int]) ?? [0, 0 , 0 , 0]
                let box = Box(x1: boxArr[0], y1: boxArr[1], x2: boxArr[2], y2: boxArr[3])
                let item = ProductType(box: box, score: score, type: type)
                
                if let attributes = dict["attributes"] as? [String: Any] {
                    item.attributes = attributes
                }
                
                results.append(item)
            }
        }
        
        return results
    }
    
    // retrieve this field as float
    private func parseFloat(_ dict:  [String:Any], _ field: String) -> Float{
      
        if let floatScore = dict[field] as? Float {
            return floatScore
        }
        
        if let numScore = dict[field] as? NSNumber {
            return numScore.floatValue
        }
        
        if let intScore = dict[field] as? Int {
           return Float(intScore)
        }
        
        if let floatVal = Float(String(describing: dict[field]) ) {
            return floatVal
        }
        
        return 0
    }
}
