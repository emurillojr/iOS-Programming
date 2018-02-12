//
//  Weather.swift
//  WeatherApp
//
//  Created by user135340 on 2/11/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

// json api data example
//http://api.wunderground.com/api/8eb0cec557955d5f/forecast10day/q/CA/San_Francisco.json

// structure that models the weather response that we get from the api

import Foundation

// model the response using the Codable protocol

// forcast is a dictionary in the response - model this first
class Weather: Codable { // conform to Codable
    let forcast: Forecast // root of response
}

// structures
// forcast text
struct Forecast: Codable {
    let forecastText: ForecastText
    // tells swift that response has different keys than provided in property names
    private enum CodingKeys: String, CodingKey {
        case forecastText = "txt_forecast" // key name in response    case object = variable
    }
}

// 10 day forcast
struct ForecastText: Codable {
    let date: String // date in response
    let forcastDays: [ForecastDay]  // array in response
    // tells swift that response has different keys than provided in property names
    private enum CodingKeys: String, CodingKey {
        case date // variable same as key
        case forcastDays = "forcastday"  // key name in response
    }
}

// get weather data
struct ForecastDay: Codable{
    let iconUrl: String
    let day: String
    let description: String
    // tells swift that response has different keys than provided in property names
    private enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url" // key name in response
        case day = "title" // key name in response
        case description = "fcttext" // key name in response
    }
}
