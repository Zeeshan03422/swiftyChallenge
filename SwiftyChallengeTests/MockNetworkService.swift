//
//  MockNetworkService.swift
//  SwiftyChallengeTests
//
//  Created by Syed Zeeshan Rizvi on 6/6/22.
//  Copyright © 2022 Monish Syed . All rights reserved.
//

import Foundation
@testable import SwiftyChallenge

enum ResponseType: String {
    case success
    case invalidJson
    case failure
}

class MockNetworkService: Service {
    
    var resposeType: ResponseType = .success
    var jsonManager = JsonManager()
    
    func get(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        switch resposeType {
        case .success:
            do {
                let data = try jsonManager.getJsonData(pathName: resposeType.rawValue)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        case .invalidJson:
            do {
                let data = try jsonManager.getJsonData(pathName: resposeType.rawValue)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        case .failure:
            completion(.failure(NSError(domain: "Server Not Responding", code: 404, userInfo: nil)))
        }
    }
}
