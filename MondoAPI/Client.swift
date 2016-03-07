//
//  Client.swift
//  MondoAPI
//
//  Created by Daniel Tomlinson on 07/03/2016.
//  Copyright © 2016 Rocket Apps. All rights reserved.
//

import Foundation
import Interstellar

/**
 *  `Client` exposes methods to allow you to easily use the Mondo Banking API.
 *
 *  As this library does not currently work on servers, and is therefore always
 *  a public client, I have not yet implemented API token refreshing.
 */
public class Client {
    private let accessToken: String
    private let network = Network()
    private let baseURL: NSURL
    public var responseQueue: dispatch_queue_t = dispatch_get_main_queue()
    
    /**
     Create a new instance of `Client`.
     
     - parameter accessToken: An API token to use for authenticating requests.
     - parameter baseURL:     The baseURL to use for requests, optional, defailts to https://api.getmondo.co.uk
     */
    public init(accessToken: String, baseURL: NSURL = NSURL(string: "https://api.getmondo.co.uk")!) {
        self.accessToken = accessToken
        self.baseURL = baseURL
    }
}

extension Client {
    public func requestTransaction(withIdentifier identifier: String, completion: Result<NSDictionary> -> ()) -> NSURLSessionTask {
        let endpoint = MondoEndpoints.Transactions.findWithIdentifier(accessToken, transactionIdentifier: identifier)
        return request(endpoint, completion: completion)
    }
    
    public func requestTransactions(forAccount accountIdentifier: String, completion: Result<NSDictionary> -> ()) -> NSURLSessionTask  {
        let endpoint = MondoEndpoints.Transactions.listForAccount(accessToken, accountIdentifier: accountIdentifier)
        return request(endpoint, completion: completion)
    }
}

extension Client {
    public func requestBalance(forAccount accountIdentifier: String, completion: Result<NSDictionary> -> ()) -> NSURLSessionTask {
        let endpoint = MondoEndpoints.Balance.forAccount(accessToken, accountIdentifier: accountIdentifier)
        return request(endpoint, completion: completion)
    }
}

extension Client {
    @warn_unused_result
    private func request<T>(endpoint: Endpoint, map: NSDictionary throws -> T, completion: Result<T> -> ()) -> NSURLSessionTask {
        let (task, signal) = request(endpoint)
        signal.flatMap(map).subscribe(onResponseQueue(completion))
        
        return task
    }
    
    @warn_unused_result
    private func request(endpoint: Endpoint, completion: Result<NSDictionary> -> ()) -> NSURLSessionTask {
        let (task, signal) = request(endpoint)
        signal.subscribe(onResponseQueue(completion))
        return task
    }
    
    @warn_unused_result
    private func request(endpoint: Endpoint) -> (NSURLSessionTask, Signal<NSDictionary>) {
        let (task, signal) = network.request(endpoint.urlRequest(baseURL))
        return (task, signal.flatMap { (data) -> NSDictionary in
            return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as! NSDictionary
        })
    }
    
    private func onResponseQueue<T>(block: (T) -> ()) -> (T) -> () {
        return { t in
            dispatch_async(self.responseQueue) { block(t) }
        }
    }
}