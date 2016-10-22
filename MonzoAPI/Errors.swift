//
//  Errors.swift
//  MonzoAPI
//
//  Created by Daniel Tomlinson on 07/03/2016.
//  Copyright © 2016 Rocket Apps. All rights reserved.
//

import Foundation

public enum Error : ErrorType {
    /**
     *  Thrown when receiving an invalid HTTP response
     *
     *  @param NSURLResponse? Optional URL response that has triggered the error
     */
    case InvalidHTTPResponse(response: NSURLResponse?)
}
