//
//  ResponseParserTests.swift
//  ProductCatTests
//
//  Created by Hung on 9/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import XCTest
@testable import ProductCat

class ResponseParserTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseResponse() {
        let json: String = """
        {
            "im_id": "202004083657fc36cb941ddfc8e1d5a4436e818c5493c180eac.jpg",
            "reqid": "05OLLHBK15RUP75Q266A4ECR",
            "status": "OK",
            "error": [],
            "product_types": [
                {
                    "type": "eyewear",
                    "score": 0.775,
                    "box": [
                        128,
                        579,
                        1017,
                        947
                    ],
                    "attributes": {}
                }
            ],
            "result": [
                {
                    "pgid": "e118158500ff5ce596346ff78af67596",
                    "main_image": "https://imgresize.visenze.com/512x512/4413606067000017b35e672aae006e012226076c74.jpg",
                    "images": [
                        "https://www.charleskeith.com/on/demandware.static/-/Sites-ck-products/default/dw61b93fe7/images/hi-res/2019-L6-CK3-11280374-01-1.jpg"
                    ],
                    "title": "Black Square Double Bridge Sunglasses",
                    "desc": "Add structure to your look with these black-tinted square sunglasses. Let them slide seamlessly into a tee and tailored pants combo.",
                    "brand": "Charles & Keith",
                    "brand_id": "1074300717",
                    "country": "SG",
                    "min_price": 47.9,
                    "max_price": 47.9,
                    "min_o_price": 59.9,
                    "max_o_price": 59.9,
                    "price_unit": "SGD",
                    "price_symbol": "S$",
                    "original_min_price": 47.9,
                    "original_max_price": 47.9,
                    "original_min_o_price": 59.9,
                    "original_max_o_price": 59.9,
                    "original_price_unit": "SGD",
                    "attrs": {
                        "source": "CHARLESNKEITH-SG"
                    },
                    "stores": [
                        {
                            "store_id": 426790539,
                            "name": "Charles & Keith",
                            "availability": 1
                        }
                    ],
                    "availability": 1,
                    "product_url": "https://productcat-api.visenze.com/redirect/CHARLESNKEITH-SG_CK3-11280374_BLACK_R?cid=1005&reqid=05OLLHBK15RUP75Q266A4ECR&pos=1&country=SG",
                    "pid": "CHARLESNKEITH-SG_CK3-11280374_BLACK_R"
                },
                {
                    "pgid": "af040c85e64755c5a010bc00d8954445",
                    "main_image": "https://productcat.visenze.com/track/1005?reqid=05OLLHBK15RUP75Q266A4ECR&pid=CHARLESNKEITH-SG_CK3-11280374_RED_R&s=426790539&action=view&u=https%3A%2F%2Fimgresize.visenze.com%2F512x512%2F4413606067000017b35e672ab0006c000d51d1255a.jpg&p=2&country=&uid=&n=CHARLESNKEITH-SG_CK3-11280374_BLACK_R&ns=426790539",
                    "images": [
                        "https://www.charleskeith.com/on/demandware.static/-/Sites-ck-products/default/dwe0bea60a/images/hi-res/2019-L6-CK3-11280374-08-1.jpg"
                    ],
                    "title": "Red Square Double Bridge Sunglasses",
                    "desc": "Audacious and angular, these red-tinted square sunglasses will add edge to your wardrobe. Pair them with a dress to give a feminine look some oomph.",
                    "brand": "Charles & Keith",
                    "brand_id": "1074300717",
                    "country": "SG",
                    "min_price": 47.9,
                    "max_price": 47.9,
                    "min_o_price": 59.9,
                    "max_o_price": 59.9,
                    "price_unit": "SGD",
                    "price_symbol": "S$",
                    "original_min_price": 47.9,
                    "original_max_price": 47.9,
                    "original_min_o_price": 59.9,
                    "original_max_o_price": 59.9,
                    "original_price_unit": "SGD",
                    "attrs": {
                        "source": "CHARLESNKEITH-SG"
                    },
                    "stores": [
                        {
                            "store_id": 426790539,
                            "name": "Charles & Keith",
                            "availability": 1
                        }
                    ],
                    "availability": 1,
                    "product_url": "https://productcat-api.visenze.com/redirect/CHARLESNKEITH-SG_CK3-11280374_RED_R?cid=1005&reqid=05OLLHBK15RUP75Q266A4ECR&pos=2&country=SG",
                    "pid": "CHARLESNKEITH-SG_CK3-11280374_RED_R"
                }
            ],
            "recognize_result": [
                {
                    "tag_group": "category",
                    "tags": [
                        {
                            "tag_id": "root|glasses",
                            "tag": "glasses",
                            "score": 0.8575329780578613
                        },
                        {
                            "tag_id": "root|glasses|sunglasses",
                            "tag": "sunglasses",
                            "score": 0.6294518113136292
                        },
                        {
                            "tag_id": "root|glasses|sporty",
                            "tag": "sporty",
                            "score": 0.31161823868751526
                        },
                        {
                            "tag_id": "root|glasses|eyeglasses",
                            "tag": "eyeglasses",
                            "score": 0.19708482921123505
                        }
                    ]
                }
            ],
            "facets": [
                {
                    "items": [
                        {
                            "count": 22,
                            "name": "Farfetch",
                            "id": 951123913,
                            "value": "FARFETCH-PRF-AF-GB"
                        },
                        {
                            "count": 19,
                            "name": "Italist",
                            "id": 2132596518,
                            "value": "ITALIST-AU"
                        },
                        {
                            "count": 12,
                            "name": "Charles & Keith",
                            "id": 426790539,
                            "value": "CHARLESNKEITH-SG"
                        }
                    ],
                    "key": "store"
                },
                {
                   "range": {
                       "min": 2.5,
                       "max": 1081.44
                   },
                   "key": "price"
                }
            ]
        }

"""
        
        let jsonData: Data? = json.data(using: .utf8)
        if let summaryResponse = ProductSummaryResponse(data: jsonData!) {
            XCTAssertEqual("05OLLHBK15RUP75Q266A4ECR", summaryResponse.reqid)
            XCTAssertEqual("202004083657fc36cb941ddfc8e1d5a4436e818c5493c180eac.jpg", summaryResponse.imId)
            XCTAssertFalse(summaryResponse.hasError)
            XCTAssertEqual("OK" , summaryResponse.status)
            
            let prodTypes = summaryResponse.productTypes
            XCTAssertEqual(1, prodTypes.count)
            let prodTypeObj = prodTypes[0]
            XCTAssertEqual("eyewear" , prodTypeObj.type)
            XCTAssertEqual("0.775" , String(prodTypeObj.score) )
            XCTAssertEqual("128,579,1017,947" , "\(prodTypeObj.box.x1),\(prodTypeObj.box.y1),\(prodTypeObj.box.x2),\(prodTypeObj.box.y2)" )
            
            
        }
        
    }

}
