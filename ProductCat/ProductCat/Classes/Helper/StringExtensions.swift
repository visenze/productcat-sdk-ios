//
//  StringExtensions.swift
//  ProductCat
//
//  Created by Hung on 7/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

public extension String {
   
    func joinInts(_ elements: [Int]) -> String {
       return elements.map{String($0)}.joined(separator: self)
    }
    
    func joinStrings(_ elements: [String]) -> String {
        return elements.joined(separator: self)
    }
}
