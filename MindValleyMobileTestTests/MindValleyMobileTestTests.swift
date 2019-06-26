//
//  MindValleyMobileTestTests.swift
//  MindValleyMobileTestTests
//
//  Created by Engineer 144 on 22/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest
@testable import MindValleyMobileTest


class MindValleyMobileTestTests: XCTestCase {

    var pins : [PinModel]!
    var imageCache : ImageCache!
    var defaultImageCacheTotalCostLimit : Int!
    
    
    override func setUp() {
       
        defaultImageCacheTotalCostLimit = ImageCache.shared.cache.totalCostLimit
        
        imageCache =  ImageCache.init(totalCost: 20)
        
        self.pins = []
        
    }
    override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
      }

  
    func test_data_response(){
        
        let results = expectation(description: "Decoded response from server to ViewsModel")
        
             HTTPClient()
            .setMethod(.get)
            .setURL(url: Constants.BaseURL)
            .setParameter(params: [:])
            .setHeader(header: [:])
            .response { data in
                
                
               
                   
                    let response = try?  JSONDecoder().decode(PinModelResponse.self, from: data.data!)
                    if response != nil {
                        
                        self.pins = response?.compactMap({ (element) in
                            
                            PinModel(pin: element)
                            
                            
                        }) ?? []
                        XCTAssertNotNil(self.pins)
                     
                    }else{
                        XCTFail("Failed to decode response from server")
                    }
                
                  results.fulfill()
               }
        
        
        
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertNil(error, "Test timed out \(error.debugDescription)")
        }
        
        
        addTeardownBlock {
            
            
             XCTAssert(self.pins.count > 0 , "We are more than O")
        }
    }
    func test_configurable_cache_totalCost(){
    
    
    XCTAssert(defaultImageCacheTotalCostLimit <  imageCache.cache.totalCostLimit, "Configured Cache Total Cost Limit was updated")

    }
  

}
