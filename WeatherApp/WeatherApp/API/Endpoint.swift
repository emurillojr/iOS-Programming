//
//  Endpoint.swift
//  WeatherApp
//
//  Created by user135340 on 2/12/18.
//  Copyright © 2018 Murillo. All rights reserved.
//


// end point for the json response, endpoint for the weather api

import Foundation

// protocol
protocol Endpoint {
    // requirements
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get } // allows to specify parameters to the end of the endpoint url
}

// protocol extension on Endpoint
// default implementation
extension Endpoint {
    // constructing url for request
    var urlComponent: URLComponents {  // structure that parses URLs into and constructs URL's from their constituent parts
        var component = URLComponents(string: baseUrl) // pass in base url
        component?.path = path // path
        component?.queryItems = queryItems //
        
        return component!
    }
    // create request
    var request: URLRequest {
        return URLRequest(url: urlComponent.url!)
    }
}

enum WeatherEndpoint: Endpoint { // conforms to Endpoint
    case tenDayForecat(city: String, state: String)
    
    var baseUrl: String {
        return "https://api.wunderground.com"
    }
    
    var path: String {
        switch self {
        case .tenDayForecat(let city, let state):
            return "/api/8eb0cec557955d5f/forecast10day/q/\(state)/\(city).json"
        }
    }
    
    var queryItems: [URLQueryItem] {
        return [] // return empty array - not using queryItems
    }
}


