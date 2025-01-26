//
//  GetWeatherUseCase.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation

struct GetWeatherUseCase{
    let weatherRepository: GetWeatherProtocol
    
    init(weatherRepository: GetWeatherProtocol) {
        self.weatherRepository = weatherRepository
    }
    
    func executeGetWeather(city: String) async -> Result<WeatherResponse, APIError> {
        return await weatherRepository.getWeather(city: city)
    }
    
    func executeGetForecast(city: String) async -> Result<ForecastResponse, APIError> {
        return await weatherRepository.getForecast(city: city)
    }
}
