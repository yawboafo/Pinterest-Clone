//
//  Extension+UIImageView.swift
//  MindValleyMobileTest
//
//  Created by Engineer 144 on 24/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import UIKit


private let dataLoader = MOperationManager()
extension UIImageView {
    
    
    //Rounded UIImageView
    func rounded(){
        self.layer.cornerRadius = (self.frame.size.width ) / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    
    //load Data
   func setImage(url: String){
    
    
    
    
    self.image = UIImage(named: "white")
    
    
    
    //check cache for image with url as identifier
    if let _image = ImageCache.shared[url as NSString] {
        
        mainThread  {
            self.image = _image
        }
        
        
    }else{
        //did not find image use library to load it
        dataLoader.loadData(urlString: url) { data in
            
            
            
            
            if let  _image = UIImage(data: data.data ?? Data()) {
              
                mainThread {
                    self.transition(toImage: _image)
                }
                
                  ImageCache.shared[url as NSString] = _image
                
            }else{
                
                mainThread {
                    self.image = UIImage(named: "white")
                    ImageCache.shared[url as NSString] = UIImage(named: "white")
                }
            }
        }
    }
        
    
   
   
    
    }
   func transition(toImage image: UIImage?) {
    UIView.transition(with: self, duration: 0.3,
                        options: [.transitionFlipFromBottom],
                        animations: {
                        self.image = image},
                        completion: nil)
}
    
    

    
}
