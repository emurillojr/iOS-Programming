//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by user135340 on 2/12/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

import Foundation

class WeatherAPIClient: APIClient {
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func weather(with endpoint: WeatherEndpoint, completion: @escaping (Either<ForecastText, APIError>) -> Void){
        let request = endpoint.request
        self.fetch(with: request) { (either: Either<Weather, APIError>) in
            switch either {
            case .value(let weather):
                let weather = weather.forcast.forecastText
                completion(.value(weather))
                
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
