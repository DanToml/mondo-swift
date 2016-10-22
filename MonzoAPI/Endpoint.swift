//
//  Endpoint.swift
//  MonzoAPI
//
//  Created by Daniel Tomlinson on 07/03/2016.
//  Copyright © 2016 Rocket Apps. All rights reserved.
//

import Foundation

class Endpoint {
    let uri: String
    let method: Method
    let headers: [String : String]
    let parameters: [String : AnyObject]

    init(uri: String, method: Method, parameters: [String : AnyObject] = [:], headers: [String : String] = [:]) {
        self.uri = uri
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }

    func urlRequest(baseURL: NSURL) -> NSURLRequest {
        let components = NSURLComponents(URL: NSURL(string: uri, relativeToURL: baseURL)!, resolvingAgainstBaseURL: true)!
        let url = components.URL!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.HTTPBody = ParameterEncoder.encode(parameters).dataUsingEncoding(NSUTF8StringEncoding)

        return request.copy() as! NSURLRequest
    }
}
