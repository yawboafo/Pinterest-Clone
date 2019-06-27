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

    var pinModel : PinViewModel!
    var pins : [PinModel]!
    var imageCache : ImageCache!
    var defaultImageCacheTotalCostLimit : Int!
    
    
    override func setUp() {
        
        pinModel = PinViewModel()
       
        defaultImageCacheTotalCostLimit = ImageCache.shared.cache.totalCostLimit
        
        imageCache =  ImageCache.init(totalCost: 20)
        
      
        
    }
    override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
      }


    
    
    func test_configurable_cache_totalCost(){
        
        
        XCTAssert(defaultImageCacheTotalCostLimit <  imageCache.cache.totalCostLimit, "Configured Cache Total Cost Limit was updated")
        
    }
    func test_pin_response_transformer(){
    
    let data = pinModel.loadPinsFromServer()
    
    if(data != nil){
    let dataList = pinModel.transformResponseToPinModels(response: data!)
        
        XCTAssertTrue(dataList.count > 0, "Transform was good")
    }else{
        XCTAssertFalse(true, "TransFormation  was Bad")
    }
    
    
    
}
    func test_load_pins_from_Server(){
    
    XCTAssertNotNil(pinModel.loadPinsFromServer(url: Constants.BaseURL))
   }
    func test_api_call_withHTTPclient(){
    
    let result = expectation(description: "Returned useful data")
    HTTPClient(urlString: Constants.BaseURL)
        .setMethod(.get)
        .setHeader(header: [:])
        .setParameter(params: [:])
        .response { response in
            XCTAssertNil(response.error, "error occured \(String(describing: response.error))")
            XCTAssertNotNil(response.data, "pay load data ")
            result.fulfill()
    }
    
    waitForExpectations(timeout: 10) { error in
        XCTAssertNil(error, "\(String(describing: error?.localizedDescription))")
    }
}
    
    

}
