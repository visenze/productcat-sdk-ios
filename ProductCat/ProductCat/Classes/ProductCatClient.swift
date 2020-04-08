//
//  ProductCatClient.swift
//  ProductCat
//
//  Created by Hung on 7/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

public enum ViHttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public enum APIMethod: String {
    case PRODUCT_SEARCH  = "summary/products"
    case SRP = "summary/products/srp"
    case SIMILAR = "similar/products"
    case APP_DEEPLINK = "app_deeplink"
    case REDIRECT = "redirect"
    case USER_PRIVACY = "users/privacy"
    case VISUAL_RECOGNIZE = "visual/recognize"
}


open class ProductCatClient: NSObject, URLSessionDelegate {
    public static let DEFAULT_ENDPOINT = "https://productcat.visenze.com"
    public static let DEFAULT_CN_ENDPOINT = "https://productcat.visenze.com.cn"
    private static let userAgentHeader : String = "User-Agent"
 
    public typealias SuccessHandler = (SimpleResponse?) -> ()
    
    public typealias SuccessSearchResultsHandler = (ProductSummaryResponse?) -> ()
    
    public typealias FailureHandler = (Error) -> ()
    
    // MARK: properties
        
    public var appKey    : String
    public var country   : String
    public var baseUrl   : String
    
    public var session: URLSession
    public var sessionConfig: URLSessionConfiguration

    public var timeoutInterval : TimeInterval = 20 // how long to timeout request
    public var requestSerialization: RequestSerialization
    
    public var userAgent : String = "productcat-ios/unknown"
    
    public convenience init?(appKey: String, country: String){
        let baseUrl = country == "CN" ? ProductCatClient.DEFAULT_CN_ENDPOINT : ProductCatClient.DEFAULT_ENDPOINT
        self.init(baseUrl: baseUrl, appKey: appKey, country: country, timeout: 20)
    }
    
    public init?(baseUrl: String, appKey: String , country: String, timeout: TimeInterval) {
        
        if appKey.isEmpty || baseUrl.isEmpty || country.isEmpty {
            return nil;
        }
        
        self.baseUrl = baseUrl
        self.appKey = appKey
        self.country = country
        self.timeoutInterval = timeout
        
        self.requestSerialization = RequestSerialization()
        
        // config default session
        sessionConfig = URLSessionConfiguration.default
        sessionConfig.allowsCellularAccess = true
        sessionConfig.timeoutIntervalForRequest = timeoutInterval
        sessionConfig.timeoutIntervalForResource = timeoutInterval
        
        // Configuring caching behavior for the default session
        let cachesDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheURL = cachesDirectoryURL.appendingPathComponent("productcatCache")
        let diskPath = cacheURL.path
        
        let cache = URLCache(memoryCapacity:16384, diskCapacity: 268435456, diskPath: diskPath)
        sessionConfig.urlCache = cache
        sessionConfig.requestCachePolicy = .useProtocolCachePolicy
        
        session = URLSession(configuration: sessionConfig)
        
        // set default user agent
        let info = Bundle.main.infoDictionary
        let appVersion = info?["CFBundleShortVersionString"] as? String ?? "Unknown"
        self.userAgent = "productcat-ios/\(appVersion)"
        
    }
    
    // MARK: APIs
    
    public func textSearch(params: TextSearchParams,
                            successHandler: @escaping SuccessSearchResultsHandler,
                            failureHandler: @escaping FailureHandler
        ) -> URLSessionTask
    {
        return makeGetApiRequest(params: params,
                                 apiMethod: .PRODUCT_SEARCH,
                                 successHandler: {
                                      (data: SimpleResponse?) -> Void in
                                     
                                     successHandler(data as? ProductSummaryResponse)
                                 },
                                 failureHandler: failureHandler)
    }
    
    @discardableResult public func imageSearch(
         params: ImageSearchParams,
         successHandler: @escaping SuccessSearchResultsHandler,
         failureHandler: @escaping FailureHandler) -> URLSessionTask
    {
        
        let request = self.buildSearchPostRequest(params: params, apiMethod: .PRODUCT_SEARCH)
        
        return httpPost(apiMethod: .PRODUCT_SEARCH,
                        request: request,
                        successHandler: {
                        (data: SimpleResponse?) -> Void in
                            successHandler(data as? ProductSummaryResponse)
                        },
                        failureHandler: failureHandler )
    }
    
    @discardableResult public func imageSearchResultsPage(
         params: ImageSearchParams,
         successHandler: @escaping SuccessSearchResultsHandler,
         failureHandler: @escaping FailureHandler) -> URLSessionTask
    {
        
        let request = self.buildSearchPostRequest(params: params, apiMethod: .SRP)
        
        return httpPost(apiMethod: .SRP,
                        request: request,
                        successHandler: {
                        (data: SimpleResponse?) -> Void in
                            successHandler(data as? ProductSummaryResponse)
                        },
                        failureHandler: failureHandler )
    }
    
    private func buildSearchPostRequest(params: ImageSearchParams, apiMethod: APIMethod) -> NSMutableURLRequest {
        // NOTE: image must be first line before generating of url
        // url box parameters depend on whether the compress image is generated
        let imageData = params.generateCompressImageForUpload()
        
        let url = requestSerialization.generateRequestUrl(baseUrl: baseUrl, apiMethod: apiMethod , searchParams: params, appKey: self.appKey)
        
        let request = NSMutableURLRequest(url: URL(string: url)! , cachePolicy: .useProtocolCachePolicy , timeoutInterval: timeoutInterval)
        
        let boundary = MultipartFormData.randomBoundary()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = MultipartFormData.encode(imageData: imageData, boundary: boundary);
        
        return request
    }
    
    
    // MARK: http requests internal
    
    private func makeGetApiRequest(params: BaseSearchParams,
                                   apiMethod: APIMethod,
                                   successHandler: @escaping SuccessHandler,
                                   failureHandler: @escaping FailureHandler
        ) -> URLSessionTask{
        
        let url = requestSerialization.generateRequestUrl(baseUrl: baseUrl, apiMethod: apiMethod , searchParams: params, appKey: self.appKey)
       
        let request = NSMutableURLRequest(url: URL(string: url)! , cachePolicy: .useProtocolCachePolicy , timeoutInterval: timeoutInterval)
        
        return httpGet(
            apiMethod: apiMethod,
            request: request,
            successHandler: {
                 (data: SimpleResponse?) -> Void in
                
                // can track automatically here if needed in future
                successHandler(data)
            },
            failureHandler: failureHandler )
        
    }
    
    private func httpGet(
                         apiMethod: APIMethod,
                         request: NSMutableURLRequest,
                         successHandler: @escaping SuccessHandler,
                         failureHandler: @escaping FailureHandler) -> URLSessionTask
    {
        return httpRequest(apiMethod: apiMethod, method: ViHttpMethod.GET, request: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    private func httpPost(
                         apiMethod: APIMethod,
                         request: NSMutableURLRequest,
                         successHandler: @escaping SuccessHandler,
                         failureHandler: @escaping FailureHandler) -> URLSessionTask
    {
        return httpRequest(apiMethod: apiMethod, method: ViHttpMethod.POST, request: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    private func httpRequest(
                 apiMethod: APIMethod,
                 method: ViHttpMethod,
                 request: NSMutableURLRequest,
                 successHandler: @escaping SuccessHandler,
                 failureHandler: @escaping FailureHandler) -> URLSessionTask {
        
        request.httpMethod = method.rawValue
        let task = createSessionTaskWithRequest(apiMethod: apiMethod, request: request, successHandler: successHandler, failureHandler: failureHandler)
        task.resume()
        
        return task
    }
    
    /**
     *  create data task session for request
     *
     *  @param URLRequest   request
     *  @param SuccessHandler success handler closure
     *  @param FailureHandler failure handler closure
     *
     *  @return session task
     */
    private func createSessionTaskWithRequest(
        apiMethod: APIMethod,
        request: NSMutableURLRequest,
        successHandler: @escaping SuccessHandler,
        failureHandler: @escaping FailureHandler) -> URLSessionTask
    {
        request.addValue(self.userAgent, forHTTPHeaderField: ProductCatClient.userAgentHeader )
        
        let task = session.dataTask(with: request as URLRequest , completionHandler:{
            (data, response, error) in
            if (error != nil) {
                failureHandler(error!)
                return
            }
            
            if response == nil || data == nil {
                successHandler(nil)
                return
            }
            
            // TODO: we may have different response depending on API method
            // most api method would follow ProductSummaryResponse
            let responseData = ProductSummaryResponse(response: response!, data: data!)
            
            successHandler(responseData)
            
        })
        
        return task
    }
    
    
}
