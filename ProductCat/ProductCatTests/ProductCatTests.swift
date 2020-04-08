//
//  ProductCatTests.swift
//  ProductCatTests
//
//  Created by Hung on 6/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import XCTest
@testable import ProductCat

class ProductCatTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClient() {
        // for real test put in the key
        ProductCat.sharedInstance.setup(appKey: "XX", country: "SG")

        if !ProductCat.sharedInstance.isClientSetup() {
            return
        }
        
        let expectation = self.expectation(description: "wait_for_response")
        
        let imgSearchParams = ImageSearchParams(
            country: ProductCat.sharedInstance.client!.country ,
            imUrl: "https://www.charleskeith.com/on/demandware.static/-/Sites-ck-products/default/dwe0bea60a/images/hi-res/2019-L6-CK3-11280374-08-1.jpg")
        ProductCat.sharedInstance.imageSearch(params: imgSearchParams!,
                                              successHandler: {
                              (data : ProductSummaryResponse?) -> Void in
                                  // Do something when request succeeds
                                  // preview by calling : dump(data)
                                  // check data.hasError and data.error for any errors return by ViSenze server
                                  dump(data)
                                                
                                  expectation.fulfill()
                                                
                          },
                         failureHandler: {
                              (err) -> Void in
                              // Do something when request fails e.g. due to network error
                              print ("error: \\(err.localizedDescription)")
                              expectation.fulfill()
                          })
        
        
        /*let textSearchParams = TextSearchParams(country: "SG", q: "nike")
        textSearchParams.facets = ["store" , "brand", "price"]
        textSearchParams.limit = 1
        ProductCat.sharedInstance.textSearch(params: textSearchParams,
                             successHandler: {
             (data : ProductSummaryResponse?) -> Void in
                 // Do something when request succeeds
                 // preview by calling : dump(data)
                 // check data.hasError and data.error for any errors return by ViSenze server
                 dump(data)
                 
                 expectation.fulfill()
                               
         },
        failureHandler: {
             (err) -> Void in
             // Do something when request fails e.g. due to network error
             print ("error: \\(err.localizedDescription)")
             expectation.fulfill()
         })
        */
        
        waitForExpectations(timeout: 30, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
