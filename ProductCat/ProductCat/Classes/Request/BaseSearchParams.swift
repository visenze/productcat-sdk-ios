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
    
    /// client request id
    public var clientReqId : String? = nil
    
    //MARK: device tracking
    
    /// Unique string that can identify the user/app
    public var uid : String? = nil
    
    public var uip: String? = nil
    
    public var ua: String? = nil
    
    public var deviceModel: String? = nil
    
    public var os: String? = nil
    
    public var osv: String? = nil
    
    public var didmd5: String? = nil
    
    public var ifa: String? = nil
    
    public var geo: String? = nil
    
    //MARK: analytics
    public var source: String? = nil
    
    public var cp1: String? = nil
    
    public var cp2: String? = nil
    
    // custom map for future parameters
    public var custom: [String: String] = [:]
    
    //MARK: sponsored content
    public var returnSponsoredContent: Bool? = nil
    
    public var sBannerImgWidth: Int?
    
    public var sBannerImgWidthMin: Int?
    
    public var sBannerImgHeight: Int?
    
    public var sBannerImgHeightMin: Int?
    
    public var sBannerImgMime: String?
    
    public var sTitleMaxLen: Int?
    
    public var sDescMaxLen: Int?
    
    public var sImgWidth: Int?
    
    public var sImgWidthMin: Int?
    
    public var sImgHeight: Int?
    
    public var sImgHeightMin: Int?
    
    public var sImgMime: String?
    
    
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
        
        addDeviceTrackingParams(&dict)
        
        if let source = self.source {
            dict["source"] = source
        }
        
        if let cp1 = self.cp1 {
            dict["cp1"] = cp1
        }
        
        if let cp2 = self.cp2 {
            dict["cp2"] = cp2
        }
        
        if let clientReqId = self.clientReqId {
            dict["client_reqid"]  = clientReqId
        }
        
        if facets.count > 0 {
            dict["facets"] = self.facets.joined(separator: ",")
            dict["facets_limit"] = String(self.facetsLimit)
            dict["facets_show_count"] = String(self.facetShowCount)
        }
        
        addSponsorContentParams(&dict)
        
        for (customParamKey, customParamValue) in self.custom {
            dict[customParamKey] = customParamValue
        }
        
        return dict
    }
    
    fileprivate func addDeviceTrackingParams(_ dict: inout [String : String]) {
        if let uid = self.uid {
            dict["uid"] = uid
        }
        
        if let uip = self.uip {
            dict["uip"] = uip
        }
        
        if let ua = self.ua {
            dict["ua"] = ua
        }

        if let deviceModel = self.deviceModel {
            dict["device_model"] = deviceModel
        }
        
        if let os = self.os {
            dict["os"] = os
        }
        
        if let osv = self.osv {
            dict["osv"] = osv
        }
        
        if let didmd5 = self.didmd5 {
            dict["didmd5"] = didmd5
        }
        
        if let ifa = self.ifa {
            dict["ifa"] = ifa
        }
        
        if let geo = self.geo {
           dict["geo"] = geo
        }
        
    }
    
    fileprivate func addSponsorContentParams(_ dict: inout [String : String]) {
        if self.returnSponsoredContent ?? false {
            dict["return_sponsored_content"] = "true"
           
            if let bannerImgWidth = self.sBannerImgWidth {
                dict["s_banner_img_w"] = String(bannerImgWidth)
            }
        
            if let bannerImgWidthMin = self.sBannerImgWidthMin {
                dict["s_banner_img_wmin"] = String(bannerImgWidthMin)
            }
        
            if let bannerImgHeight = self.sBannerImgHeight {
                dict["s_banner_img_h"] = String(bannerImgHeight)
            }
        
            if let bannerImgHeightMin = self.sBannerImgHeightMin {
                dict["s_banner_img_hmin"] = String(bannerImgHeightMin)
            }
        
            if let bannerMime = self.sBannerImgMime {
                dict["s_banner_img_mime"] = bannerMime
            }
            
            if let titleLen = self.sTitleMaxLen {
                dict["s_title_max_len"] = String(titleLen)
            }
            
            if let descLen = self.sDescMaxLen {
                dict["s_desc_max_len"] = String(descLen)
            }
            
            if let imgWidth = self.sImgWidth {
               dict["s_img_w"] = String(imgWidth)
            }
       
            if let widthMin = self.sImgWidthMin {
               dict["s_img_wmin"] = String(widthMin)
            }
       
            if let imgHeight = self.sImgHeight {
               dict["s_img_h"] = String(imgHeight)
            }
       
            if let imgHeightMin = self.sImgHeightMin {
               dict["s_img_hmin"] = String(imgHeightMin)
            }
       
            if let imgMime = self.sImgMime {
               dict["s_img_mime"] = imgMime
            }
       }
   }
}
