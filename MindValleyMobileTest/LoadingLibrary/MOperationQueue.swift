//
//  MOperationQueue.swift
//  MindValleyMobileTestLibraryTests
//
//  Created by Engineer 144 on 23/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

public class  MOperationQueue {
    
    
    // MARK: - Singleton
    
    static let shared =  MOperationQueue()
    
    lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "MOperationQueue"
        queue.maxConcurrentOperationCount = 6
        return queue;
    }()
    
    
    
    // MARK: - Addition
    
    func enqueue(_ operation: Operation) {
        queue.addOperation(operation)
    }
}

