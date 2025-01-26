//
//  GetWeatherRepository.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation

struct GetWeatherRepository: GetWeatherProtocol{
    static let shared = GetWeatherRepository()
    let weatherDataRource = WeatherRemoteDataSource()
    
    func getWeather(city: String) async -> Result<WeatherResponse, APIError> {
        
        let results = await weatherDataRource.getWeather(city: city)
        switch results {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getForecast(city: String) async -> Result<ForecastResponse, APIError> {
        
        let results = await weatherDataRource.getForecast(city: city)
        switch results {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
}
