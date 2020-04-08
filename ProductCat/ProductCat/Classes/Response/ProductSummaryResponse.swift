//
//  ProductSummaryResponse.swift
//  ProductCat
//
//  Created by Hung on 7/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

public class ProductSummaryResponse: SimpleResponse {
    
    public var imId: String?
    
    public override func parseJson(_ json: [String : Any]) {
        super.parseJson(json)
        
        self.imId  = json["im_id"] as? String
        
        if let result = json["result"] as? [Any] {
          //self.result = ResponseParser.parseResults(result)
        }

        // extract product types, product types list if necessary
        if let pTypesJson = json["product_types"] as? [Any] {
          //self.productTypes = ResponseParser.parseProductTypes(pTypesJson)
        }

        if let facetListJson = json["facets"] as? [Any] {
          //self.facets = ResponseParser.parseFacets(facetListJson)
        }
    }
}
