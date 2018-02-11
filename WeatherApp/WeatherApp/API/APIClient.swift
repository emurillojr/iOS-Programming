//
//  APIClient.swift
//  WeatherApp
//
//  Created by user135340 on 2/11/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import Foundation

enum Either<V, E: Error> {
    case value(V)
    case error(E)
}

enum APIError: Error {
    case apiError
    case badResponse
    case jsonDecoder
    case unknown(String)
}

// protocol
protocol APIClient {
    // responsibile for creating a request to the weather api
    var session: URLSession { get }
    
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Either<V, APIError>) -> Void)
}

// protocol extension
extension APIClient {
    
}
