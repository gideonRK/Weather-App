//
//  WeatherViewModel.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation

class WeatherViewModel: ObservableObject{
    @Published var state: FetchState = .good
    var weatherUseCase = GetWeatherUseCase(weatherRepository: GetWeatherRepository.shared)
    @Published var weatherResponse : WeatherResponse?
    @Published var forecastResponse : ForecastResponse?
    
    @MainActor
    func getWeather(city: String) async {
        
        state = .isLoading
        let results = await weatherUseCase.executeGetWeather(city: city)
        switch results {
        case .success(let response):
            state = .good
            print("DEGUG: weather fetched successfully\(response)")
            self.weatherResponse = response
            
            
            let weatherLocalDataSource = WeatherLocalDataSource()
            let _ = weatherLocalDataSource.insertWeatherResponse(weatherResponse: response)
            let _ = weatherLocalDataSource.getWeatherResponse()
        case .failure(let error):
            print("DEBUG: Failed to fetch the weather with error \(error.description)")
            state = .error(error.description)
        }
    }
    
    @MainActor
    func getForecast(city: String) async {
        
        state = .isLoading
        let results = await weatherUseCase.executeGetForecast(city: city)
        switch results {
        case .success(let response):
            state = .good
            print("DEGUG: forecast fetched successfully\(response)")
            self.forecastResponse = response
        case .failure(let error):
            print("DEBUG: Failed to fetch the forecast with error \(error.description)")
            state = .error(error.description)
        }
    }
}
