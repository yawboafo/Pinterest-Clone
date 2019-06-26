//
//  PinModel.swift
//  MindValleyMobileTest
//
//  Created by Engineer 144 on 24/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import UIKit
class PinModel : NSObject {
    
    var id : String!
    var height : CGFloat!
    var imageUrl: String!
    var selectedImage: UIImage!
    var userName : String!
    var userImageUrl: String!
    var likes: String!
    var categories : [String]!
    
    init(pin : Pin) {
        super.init()
        self.id = pin.id
        self.height =  heightSense(rawHeight: (pin.height ?? 0))
        self.imageUrl = pin.urls?.regular
        self.userName = pin.user?.name
        self.userImageUrl = pin.user?.profile_image?.large
        self.likes = "\(pin.likes!) likes"
        self.categories = pin.categories?.map{ $0.title ?? "" }
    }
    
 
    
    func heightSense(rawHeight: Int) -> CGFloat {
       
       if (rawHeight < 2000) {
            
            return CGFloat(rawHeight / 10 )
        }else {
              return CGFloat(rawHeight  / 15 )
        }
        
     
        
    }
    
    
   
    
}

