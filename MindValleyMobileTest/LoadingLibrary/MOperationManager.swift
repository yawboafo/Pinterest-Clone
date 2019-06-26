//
//  MOperationManager.swift
//  MindValleyMobileTestLibrary
//
//  Created by Engineer 144 on 23/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
public class MOperationManager {
    
    
    public let queueManager:  MOperationQueue
    
    // MARK: - Init
    
    public init() {
        self.queueManager =  MOperationQueue.shared
        
    }
    
    
    
    // MARK Load AnyData with URLRequest
    
    public  func loadData(request: URLRequest, completionHandler: @escaping (_ result: MOperationResponse) ->Void) {
        
        let operation = MloadDataOperation( _urlRequest: request)
        operation.qualityOfService = .background
        operation.queuePriority = .veryHigh
        operation.completionHandler = completionHandler
        operation.name = request.url?.absoluteString
        queueManager.enqueue(operation)
        
    }
    
    // MARK Load AnyData with urlString
    public  func loadData(urlString: String, completionHandler: @escaping (_ result: MOperationResponse) ->Void) {
        
        let operation = MloadDataOperation(_urlstring: urlString, withString: true)
        operation.qualityOfService = .background
        operation.queuePriority = .veryHigh
        operation.completionHandler = completionHandler
        operation.name = urlString
        queueManager.enqueue(operation)
        
    }
    
    
    
    public func slowOperation(operationID: String){
        for ops in queueManager.queue.operations {
            
            if ops.name == operationID {
                if ops.isExecuting && !ops.isFinished {
                    ops.queuePriority = .low
                    print("i found the operation \(String(describing: ops.name))")
                    
                    break
                    
                }
            }
        }
        
    }
    
    public func cancelOperation(operationID: String) {
        for ops in queueManager.queue.operations {
            
            if ops.name == operationID {
                if ops.isExecuting && !ops.isFinished{
                    
                    ops.cancel()
                    
                    break
                }
                
                
            }
        }
        
        
        
    }
}
