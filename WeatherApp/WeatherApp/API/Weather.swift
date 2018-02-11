//
//  Weather.swift
//  WeatherApp
//
//  Created by user135340 on 2/11/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

// json api data example
//http://api.wunderground.com/api/8eb0cec557955d5f/forecast10day/q/CA/San_Francisco.json


import Foundation

class Weather: Codable {
    let forcast: Forecast // first item in response
}
// structures
struct Forecast: Codable {
    let forecastText: ForecastText
    
    private enum CodingKeys: String, CodingKey {
        case forecastText = "txt_forecast" // key name in response
    }
}

struct ForecastText: Codable {
    let date: String
    let forcastDays: [ForecastDay]  // array in response
    
    private enum CodingKeys: String, CodingKey {
        case date // variable same as key
        case forcastDays = "forcastday"  // key name in response
    }
}

struct ForecastDay: Codable{
    let iconUrl: String
    let day: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url" // key name in response
        case day = "title" // key name in response
        case description = "fcttext" // key name in response
        
    }
}
