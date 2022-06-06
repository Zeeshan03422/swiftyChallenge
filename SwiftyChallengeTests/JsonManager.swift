//
//  JsonManager.swift
//  SwiftyChallengeTests
//
//  Created by Syed Zeeshan Rizvi on 6/6/22.
//  Copyright © 2022 Monish Syed . All rights reserved.
//

import Foundation

class JsonManager {
    
    func getJsonData(pathName: String) throws -> Data {
        if let path = Bundle(for: type(of:  self)).path(forResource: pathName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                throw error
            }
        } else {
            throw NSError(domain: "WebServiceError", code: -1000, userInfo: nil)
        }
        
    }
}
