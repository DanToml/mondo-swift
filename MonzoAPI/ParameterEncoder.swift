//
//  ParameterEncoder.swift
//  MonzoAPI
//
//  Created by Daniel Tomlinson on 07/03/2016.
//  Copyright © 2016 Rocket Apps. All rights reserved.
//

import Foundation

struct ParameterEncoder {
    static func encode(parameters: [String : AnyObject]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sort(<) {
            let value = parameters[key]!
            components += queryComponents(key, value: value)
        }

        return (components.map { "\($0)=\($1)" } as [String]).joinWithSeparator("&")
    }

    static func queryComponents(key: String, value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary = value as? [String : AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)[]", value: value)
            }
        } else {
            components.append((escape(key), escape("\(value)")))
        }

        return components
    }

    static func escape(string: String) -> String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        let allowedCharacterSet = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        allowedCharacterSet.removeCharactersInString(generalDelimitersToEncode + subDelimitersToEncode)

        return string.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? string
    }
}
