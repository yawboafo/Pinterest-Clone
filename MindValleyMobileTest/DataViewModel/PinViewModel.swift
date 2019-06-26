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
        loadPins()
    }
    
    
    func loadPins()  {
        
        HTTPClient().setURL(url: Constants.BaseURL).response { data in
            
           let response = try?  JSONDecoder().decode(PinModelResponse.self, from: data.data!)
            if response != nil {
                
                self.pins = response?.compactMap({ (element) in
                  
                         PinModel(pin: element)
                   
                   
                }) ?? []
                
                
            }
        }
        
        
    }
    
    func source(at index:Int) -> PinModel {
        return self.pins[index]
    }
    
    
    func invalideCachedData(){
        
        MUrlCache.shared.invalidateCache()
        ImageCache.shared.cache.removeAllObjects()
  
    }
    
    
    
}
