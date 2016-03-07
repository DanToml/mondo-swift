//
//  Network.swift
//  MondoAPI
//
//  Created by Daniel Tomlinson on 07/03/2016.
//  Copyright © 2016 Rocket Apps. All rights reserved.
//

import Foundation
import Interstellar

/**
 *  `Network` is a lightweight Swift abstraction around NSURLSession.
 */
class Network {
    private let configuration: NSURLSessionConfiguration
    private lazy var session: NSURLSession = {
        return NSURLSession(configuration: self.configuration)
    }()
    
    init(configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()) {
        self.configuration = configuration
    }
    
    func request(urlRequest: NSURLRequest) -> (NSURLSessionTask, Signal<NSData>) {
        let signal = Signal<NSData>()
        
        let task = session.dataTaskWithRequest(urlRequest) { data, response, error in
            guard let httpResponse = response as? NSHTTPURLResponse where (200..<400).contains(httpResponse.statusCode) else {
                signal.update(Error.InvalidHTTPResponse(response: response))
                return
            }
            
            if let data = data {
                signal.update(data)
                return
            }
            
            if let error = error {
                signal.update(error)
                return
            }
            
            signal.update(Error.InvalidHTTPResponse(response: response))
        }
        
        task.resume()
        
        return (task, signal)
    }
}
