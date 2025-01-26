//
//  WeatherRemoteDataSource.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation

struct WeatherRemoteDataSource{
    func getWeather(city: String) async -> Result<WeatherResponse, APIError> {
        let apiKey = Constants.API_KEY

        guard let url = Constants.APIEndpoint.getWeather(city: city, apiKey: apiKey).url else {
                   return .failure(APIError.badURL)
               }
        
        let (responseData, response) = await HttpUtilsNew.shared.secureRequestAPI(
            url: url,
            httpMethod: HttpMethod.Get
        )
        
        do {
            
            guard let data = responseData else {
                print("DEBUG: responseData is nil or empty")
                return .failure(APIError.smthWentWrong)
            }
            
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
           
                if let httpResponse = response as? HTTPURLResponse, 400..<499 ~= httpResponse.statusCode {

                    if let apiErrorMessage = json["message"] as? String {
                        var errorMessage: String
                        if apiErrorMessage.contains("JSON") || apiErrorMessage.contains("refused"){
                            errorMessage = ErrorMapperUtils.shared.mappError(apiErrorMessage) ?? apiErrorMessage
                        }
                        else {
                           
                            errorMessage = APIError.unexpected.description

                        }
                       
                        return .failure(APIError.custom(errorMessage))
                    }
                    
                }
               
            }
            
            // return decoded data
            let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return .success(decodedData)
            
        }
        catch let decodingError as DecodingError {
            print("DEBUG:  weather decodingError error, \(decodingError)")
            return .failure(APIError.unexpected)
        } catch {
            print("DEBUG: weather error, \(error.localizedDescription)")
            return .failure(APIError.unexpected)
        }
    }
    
    func getForecast(city: String) async -> Result<ForecastResponse, APIError> {
        let apiKey = Constants.API_KEY

        guard let url = Constants.APIEndpoint.getForeCast(city:city , apiKey: apiKey).url else {
                   return .failure(APIError.badURL)
               }
        
        let (responseData, response) = await HttpUtilsNew.shared.secureRequestAPI(
            url: url,
            httpMethod: HttpMethod.Get
        )
        
        do {
            
            guard let data = responseData else {
                print("DEBUG: forecast is nil or empty")
                return .failure(APIError.smthWentWrong)
            }
            
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
           
                if let httpResponse = response as? HTTPURLResponse, 400..<499 ~= httpResponse.statusCode {

                    if let apiErrorMessage = json["message"] as? String {
                        var errorMessage: String
                        if apiErrorMessage.contains("JSON") || apiErrorMessage.contains("refused"){
                            errorMessage = ErrorMapperUtils.shared.mappError(apiErrorMessage) ?? apiErrorMessage
                        }
                        else {
                           
                            errorMessage = APIError.unexpected.description

                        }
                       
                        return .failure(APIError.custom(errorMessage))
                    }
                    
                }
               
            }
            
            // return decoded data
            let decodedData = try JSONDecoder().decode(ForecastResponse.self, from: data)
            return .success(decodedData)
            
        }
        catch let decodingError as DecodingError {
            print("DEBUG: forecast decodingError error, \(decodingError)")
            return .failure(APIError.unexpected)
        } catch {
            print("DEBUG: forecast error, \(error.localizedDescription)")
            return .failure(APIError.unexpected)
        }
    }

}
