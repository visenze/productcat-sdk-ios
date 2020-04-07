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

public enum ProductCatAPIEndPoints: String {
    case PRODUCT_SEARCH  = "summary/products"
    case SRP = "summary/products/srp"
    case SIMILAR = "similar/products"
    case APP_DEEPLINK = "app_deeplink"
    case REDIRECT = "redirect"
    case USER_PRIVACY = "users/privacy"
    case VISUAL_RECOGNIZE = "visual/recognize"
}


open class ProductCatClient: NSObject {

}
