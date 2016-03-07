//
//  MondoEndpoints.swift
//  MondoAPI
//
//  Created by Danielle Lancashire on 07/03/2016.
//  Copyright © 2016 Rocket Apps. All rights reserved.
//

import Foundation

struct MondoEndpoints {
    struct Transactions {
        static func findWithIdentifier(accessToken: String, transactionIdentifier: String) -> Endpoint {
            return Endpoint(
                uri: "transactions/\(transactionIdentifier)",
                method: .GET,
                parameters: ["expand[]" : "merchant"],
                headers: ["Authorization" : "Bearer \(accessToken)"]
            )
        }
        
        static func listForAccount(accessToken: String, accountIdentifier: String) -> Endpoint {
            return Endpoint(
                uri: "transactions?account_id=\(accountIdentifier)",
                method: .GET,
                headers: ["Authorization" : "Bearer \(accessToken)"]
            )
        }
    }
    
    struct Balance {
        static func forAccount(accessToken: String, accountIdentifier: String) -> Endpoint {
            return Endpoint(
                uri: "balance?account_id=\(accountIdentifier)",
                method: .GET,
                headers: ["Authorization" : "Bearer \(accessToken)"]
            )
        }
    }
}