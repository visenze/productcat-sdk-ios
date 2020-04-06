//
//  UIColorExtensionTests.swift
//  ProductCatTests
//
//  Created by Hung on 6/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import XCTest
@testable import ProductCat

class UIColorExtensionTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testHexString() {
        XCTAssertEqual("FF0000", UIColor.red.hexString() )
        XCTAssertEqual("32A852", UIColor(red: 50.0/255.0, green:168.0/255.0 , blue: 82.0/255.0, alpha: 1.0).hexString() )
    }

}
