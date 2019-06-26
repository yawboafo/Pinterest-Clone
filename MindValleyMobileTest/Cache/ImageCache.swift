//
//  ImageCache.swift
//  MindValleyMobileTest
//
//  Created by Engineer 144 on 24/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

import UIKit
class ImageCache {
    static let shared = ImageCache()
    
    public let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol?
    private var defaultTotalCost = 0
    
    init() {
        cache.totalCostLimit = defaultTotalCost * 1024 * 1024
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] _ in
            self?.cache.removeAllObjects()
        }
    }
    
    
    init(totalCost: Int) {
        cache.totalCostLimit = totalCost * 1024 * 1024
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] _ in
            self?.cache.removeAllObjects()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(observer!)
    }
    
    subscript(url: NSString) -> UIImage? {
        get {
            return cache.object(forKey: url as NSString)
        }
        
        set {
            if let data = newValue {
                cache.setObject(data, forKey: url as NSString)
            } else {
                cache.removeObject(forKey: url as NSString)
            }
        }
    }
}
