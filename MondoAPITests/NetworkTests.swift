//
//  NetworkTests.swift
//  MondoAPI
//
//  Created by Daniel Tomlinson on 07/03/2016.
//  Copyright © 2016 Rocket Apps. All rights reserved.
//

import XCTest
@testable import MondoAPI
import Result

class NetworkTests: XCTestCase {
    let client = Client(accessToken: "")
    
    func test_list_transactions() {
        let expectation = expectationWithDescription("Blah")
        
        client.requestTransactions(forAccount: "") { result in
            print(result)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5000.0, handler: nil)
    }
}
