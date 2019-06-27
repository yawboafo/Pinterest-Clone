//
//  MloadDataOperation.swift
//  MindValleyMobileTestLibrary
//
//  Created by Engineer 144 on 23/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
class MloadDataOperation: MOperation<MOperationResponse> {
    
    //let session = URLSession()
    
    private let session: URLSession
    private var urlRequest: URLRequest?
    private var task: URLSessionTask?
    private var  cache =   MUrlCache().sharedCache
    private  var urlString : String?
    private var withOnlyString: Bool = false
    
    // Constructor  with Url and URLSession
    init(session: URLSession = URLSession.shared, _urlRequest: URLRequest) {
        self.session = session
        self.urlRequest = _urlRequest
        self.urlRequest?.cachePolicy = .returnCacheDataElseLoad
        
        
    }
    
    
    init(session: URLSession = URLSession.shared, _urlstring: String,withString: Bool) {
        self.session = session
        self.urlString = _urlstring
        self.withOnlyString = withString
        
        
        guard let finalUrl = URL(string: _urlstring) else {return}
        
        self.urlRequest = URLRequest(url: finalUrl)
        self.urlRequest?.cachePolicy = .returnCacheDataElseLoad
    }
    
    
    
  /**  override func start() {
        
        if self.withOnlyString == true {
            
            guard let url = self.urlString else {
                
                cancel()
                return
                
            }
            
            guard let finalUrl = URL(string: url) else {
                
                cancel()
                return
            }
            
            
            
            // Prepare urlRequest
            self.urlRequest = URLRequest(url: finalUrl)
            self.urlRequest?.cachePolicy = .returnCacheDataElseLoad
            
        }
        
    }**/
    
    
    
    override public func main() {
        
        if isCancelled {
            return
        }
        

        
        
        // pick UrlResponse from Cache else make new urlsession call
        if let cachedData = cache.cachedResponse(for: self.urlRequest!) {
            
            let _data = MOperationResponse("" as AnyObject, cachedData.data ,"" as AnyObject )
            self.complete(result: _data)
            self.cancel()
            
        }else{
            
            //if reponse is not stored make new URLRequest call
            task = session.dataTask(with: self.urlRequest!) { [weak self] (data, response, error) in
                
                let _data = MOperationResponse(error as AnyObject,data ?? Data(), response as AnyObject)
                self?.complete(result: _data)
                self?.cancel()
                
            }
            
            task?.resume()
            
        }
        
    
        
        
        
        
        
        
        
        
    }
    
    // MARK: - Cancel
    
    
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
    
    
}

