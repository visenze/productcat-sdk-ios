//
//  StringExtensionsTests.swift
//  ProductCatTests
//
//  Created by Hung on 7/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import XCTest

class StringExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJoins() {
        XCTAssertEqual("1,2,77", ",".joinInts([1,2,77]))
        XCTAssertEqual("", ",".joinInts([]))
        XCTAssertEqual("1,22,7", ",".joinStrings(["1","22","7"]))
        XCTAssertEqual("", ",".joinStrings([]))
        
    }


}
