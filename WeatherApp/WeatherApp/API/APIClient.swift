//
//  APIClient.swift
//  WeatherApp
//
//  Created by user135340 on 2/11/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

// Weather api
// created api client responsibile for creating request to weather api

import Foundation

// object
enum Either<V, E: Error> { // conforms to Error protocol
    case value(V) // pass in value
    case error(E) // pass in error
}

// object
enum APIError: Error { // conforms to Error protocol
    case apiError
    case badResponse
    case jsonDecoder
    case unknown(String)
}

// protocol
protocol APIClient {
    
    var session: URLSession { get }
    
    // generic function constrained to any type that is Codable
    // V for value, completion handler, @escaping - when the closure is passed as an argument to the function, but is called after the function returns, closer captures result type either error from api or weather object from api
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Either<V, APIError>) -> Void)
}

// protocol extension
extension APIClient {
    // use same function from original protocol
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Either<V, APIError>) -> Void){
        // provide default implementation
        // create task since will be making request to api
        let task = session.dataTask(with: request) { (data, response, error) in
            // if we have an error
            guard error == nil else{ // if error has value
                completion(.error(.apiError)) // pass in api error
                return
            }
            // if we have a response -  range 200 -299 success
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else{
                completion(.error(.badResponse)) // if not pass in bad response
                return
            }
            // decode data - try to decode it, pass value, pass data
            guard let value = try? JSONDecoder().decode(V.self, from: data!) else{
                completion(.error(.jsonDecoder)) // if fails, pass json decoder error
                return
            }
            // call completion with value, pass in value
            completion(.value(value))
        }
        task.resume() // in order to create the api request to the api
    }
}
