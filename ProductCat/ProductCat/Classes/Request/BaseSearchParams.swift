//
//  BaseSearchParams.swift
//  ProductCat
//
//  Created by Hung on 7/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import Foundation

/// Protocol to generate dictionary for query parameters (in the URL)
public protocol SearchParamsProtocol{
    
    
    /// Generate dictionary of parameters , will be appended into query string
    ///
    /// - returns: dictionary
    func toDict() -> [String: String]
}

open class BaseSearchParams: SearchParamsProtocol {

    public init(country: String) {
        self.country = country
    }
    
    // MARK: properties
    
    /// country
    public var country: String
    
    /// The number of results returned per page. The maximum number of results returned from the API is 100
    /// Default to 10
    public var limit : Int = 10
    
    /// The result page number.
    public var page  : Int = 1
    
    /// store ids filter
    public var storeIds: [Int] = []
    
    /// brand ids filter
    public var brandIds: [Int] = []
    
    /// price filter
    public var price: String? = nil
    
    /// custom thumbnail size in width height format e.g. 512x512
    public var thumbnailSize : String? = nil
    
    /// sortby
    public var sortBy : String? = nil
    
    /// List of fields to enable faceting i.e. store, brand or price
    public var facets    : [String] = []
    
    /// Limit of the number of facet values to be returned. Only for non-numerical fields (store, brand)
    public var facetsLimit : Int = 10
    
    /// whether to show the facets count in the response.
    public var facetShowCount : Bool = false
    
    
    
    // MARK: search protocol
    public func toDict() -> [String: String] {
        var dict : [String:String] = [:]
        
        // country is mandatory
        dict["country"] = country
        
        if limit > 0 {
            dict["limit"] = String(limit)
        }
        
        if page > 0 {
            dict["page"] = String(page)
        }
        
        if storeIds.count > 0 {
            dict["store_ids"] = ",".joinInts(self.storeIds)
        }
        
        if brandIds.count > 0 {
            dict["brand_ids"] = ",".joinInts(self.brandIds)
        }
        
        if let price = self.price {
            dict["price"] = price
        }
        
        if let thumbnailSize = self.thumbnailSize {
            dict["thumbnail_size"] = thumbnailSize
        }
        
        if let sortBy = self.sortBy {
            dict["sort_by"] = sortBy
        }
        
        if facets.count > 0 {
            dict["facets"] = self.facets.joined(separator: ",")
            dict["facets_limit"] = String(self.facetsLimit)
            dict["facets_show_count"] = self.facetShowCount ? "true" : "false"
        }
        
        return dict
    }
}
