//
//  GetWeatherProtocol.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation

protocol GetWeatherProtocol{
    func getWeather(city: String) async -> Result<WeatherResponse, APIError>
    func getForecast(city: String) async -> Result<ForecastResponse, APIError>
}
