//
//  PinViewModel.swift
//  MindValleyMobileTest
//
//  Created by Engineer 144 on 23/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation


class PinViewModel : NSObject {
    
    @objc dynamic private(set) var pins : [PinModel] = [PinModel]()
    private var token :NSKeyValueObservation?
    var bindSourceToModels :(() -> ()) = {  }
    
    
    override init() {
        super.init()
        token = self.observe(\.pins) { _, _ in
            self.bindSourceToModels()
            
        }
      
    }
    
    func loadPins()  {
    
    
    let datafromServer = loadPinsFromServer()
    if datafromServer != nil {
        self.pins = self.transformResponseToPinModels(response: datafromServer!)
    }
    
   }
    
    internal func loadPinsFromServer() -> PinModelResponse? {
    
    var response: PinModelResponse!
    let sempahone = DispatchSemaphore(value: 0)
    
        HTTPClient(urlString: Constants.BaseURL).response { data in
        response = try? JSONDecoder().decode(PinModelResponse.self, from: data.data!)
        sempahone.signal()
    }
    
    _ = sempahone.wait(timeout: .distantFuture)
    
    return response
    
    }
    internal func loadPinsFromServer(url: String) -> PinModelResponse? {

     var response: PinModelResponse!
     let sempahone = DispatchSemaphore(value: 0)

   HTTPClient(urlString: url).response { data in
    response = try? JSONDecoder().decode(PinModelResponse.self, from: data.data!)
    sempahone.signal()
    }

_ = sempahone.wait(timeout: .distantFuture)

return response

}
    internal  func transformResponseToPinModels(response: PinModelResponse)-> [PinModel] {
    
    return  response.compactMap({ (element) in
        PinModel(pin: element)
        
    })
    
}
    
    func source(at index:Int) -> PinModel {
        return self.pins[index]
    }
    func invalideCachedData(){
    
    MUrlCache.shared.invalidateCache()
    ImageCache.shared.cache.removeAllObjects()

}
    
    
    
}
