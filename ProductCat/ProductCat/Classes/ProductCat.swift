//
//  ProductCat.swift
//  ProductCat
//
//  Created by Hung on 8/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

open class ProductCat: NSObject {
    public static let sharedInstance = ProductCat()
    
    public var client : ProductCatClient?
    
    private override init(){
        super.init()
    }
    
    
    /// Check if search client is setup properly
    ///
    /// - returns: true if client is setup
    public func isClientSetup() -> Bool {
        return client != nil
    }
    
    // MARK: setup
    
    /// Setup API client. Must be called first before various API calls
    ///
    /// - parameter appKey: application app key
    /// - parameter country: which country to search
    public func setup(appKey: String, country: String) -> Void {
        if client == nil {
            client = ProductCatClient(appKey: appKey, country: country)
        }
    }
    
    public func setup(baseUrl: String, appKey: String , country: String, timeout: TimeInterval) {
        if client == nil {
            client = ProductCatClient(baseUrl:baseUrl, appKey: appKey, country: country, timeout: timeout)
        }
    }
    
    // MARK: API calls
    
    /// Text Search
    @discardableResult public func textSearch(
        params: TextSearchParams,
        successHandler: @escaping ProductCatClient.SuccessSearchResultsHandler,
        failureHandler: @escaping ProductCatClient.FailureHandler) -> URLSessionTask?
    {
        if let client = client {
            return client.textSearch(params: params, successHandler: successHandler, failureHandler: failureHandler)
        }
        
        self.printWarning()
        return nil
    }
    
    @discardableResult public func imageSearch(
        params: ImageSearchParams,
        successHandler: @escaping ProductCatClient.SuccessSearchResultsHandler,
        failureHandler: @escaping ProductCatClient.FailureHandler) -> URLSessionTask?
    {
        if let client = client {
            return client.imageSearch(params: params, successHandler: successHandler, failureHandler: failureHandler)
        }
        
        self.printWarning()
        return nil
    }
    
    @discardableResult public func imageSearchResultPage(
        params: ImageSearchParams,
        successHandler: @escaping ProductCatClient.SuccessSearchResultsHandler,
        failureHandler: @escaping ProductCatClient.FailureHandler) -> URLSessionTask?
    {
        if let client = client {
            return client.imageSearchResultsPage(params: params, successHandler: successHandler, failureHandler: failureHandler)
        }
        
        self.printWarning()
        return nil
    }
    
    private func printWarning() -> Void {
        print("\(type(of: self)).\(#function)[line:\(#line)] - error: client is not initialized. Please call setup(appKey) before using the API.")
        
    }
    
    
}
