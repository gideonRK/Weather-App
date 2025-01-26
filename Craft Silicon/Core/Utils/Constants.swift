//
//  Constants.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation

class Constants{
    static let BASE_URL = "https://api.openweathermap.org/data/2.5/"
    static let API_KEY = "6f73d60762645118c25d90ec6eb9ae7a"
    
    static let timeoutInterval: Double = 45

    
    enum APIEndpoint{
        case getWeather(city: String, apiKey: String)
        case getForeCast(city: String, apiKey: String)
        

        var url: URL? {
            switch self {
            case .getWeather(let city, let apiKey):
                var components = URLComponents(string: "\(Constants.BASE_URL)weather")
                components?.queryItems = [
                    URLQueryItem(name: "q", value: city),
                    URLQueryItem(name: "appid", value: apiKey)
                ]
                return components?.url
                
            case .getForeCast(let city, let apiKey):
                var components = URLComponents(string: "\(Constants.BASE_URL)forecast")
                components?.queryItems = [
                    URLQueryItem(name: "q", value: city),
                    URLQueryItem(name: "appid", value: apiKey)
                ]
                return components?.url
            }
        
        }
    }
}
