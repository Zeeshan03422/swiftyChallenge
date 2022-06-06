//
//  Service.swift
//  SwiftyChallenge
//
//  Created by Monish Syed  on 10/08/2020.
//  Copyright © 2020 Monish Syed . All rights reserved.
//

import Foundation

/// Create a concrete request type for each request your app supports
/// Usage:
/// ```
/// class CareemImageRequest: Request {
///     var urlRequest: URLRequest {
///         return request
///     }
/// }
/// ```
protocol Request {
    var urlRequest: URLRequest { get }
}

/// An abstract service type that can have multiple implementation for example - a NetworkService that gets a resource from the Network or a DiskService that gets a resource from Disk
protocol Service {
    func get(request: Request, completion: @escaping (Result<Data, Error>) -> Void)
}

/// A concrete implementation of Service class responsible for getting a Network resource
final class NetworkService: Service {
    
    enum ServiceError: Error {
        case noData
    }
    
    func get(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request.urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(ServiceError.noData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}

class UrlRequest: Request {
    
    var urlRequest: URLRequest {
        return URLRequest(url: URL(string: urlString)!)
    }
    
    var urlString = "https://gist.githubusercontent.com/monishsyed/7d38bbe2e512ccc2c3708168b99ff5e5/raw/6a967af106fc951979342a4a7bbdb45d8aedc845/SwiftChallenge.json"
}
