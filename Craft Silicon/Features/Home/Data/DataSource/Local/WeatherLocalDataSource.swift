//
//  WeatherLocalDataSource.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 26/01/2025.
//

import Foundation
import CoreData

struct WeatherLocalDataSource{
    
    private let viewContext = CoreDataProvider.shared.persistentContainer.viewContext

    func insertWeatherResponse(weatherResponse: WeatherResponse) -> Result<String, CoreDataError>{
        
        
        let weatherResponseCoreData = WeatherCoreData(context: viewContext)
        weatherResponseCoreData.id = Int64(weatherResponse.id)
        weatherResponseCoreData.name = weatherResponse.name
 
        // save
        do {
            try viewContext.save()
        }
        catch {
            print("DEBUG: Failed to save with error \(error.localizedDescription)")
            return .failure(CoreDataError.custom("\(error.localizedDescription)"))
        }
        
        //let _ = getWeatherResponse()
        
        return .success("Weather response saved successfully.")
    }
    
    
    func getWeatherResponse() -> Result<WeatherResponse?, CoreDataError> {
        
        let request = WeatherCoreData.fetchRequest()
        do {
            let coreDatatems: [WeatherCoreData] = try viewContext.fetch(request)
            if let firstcoreDatatem = coreDatatems.first {
                var weatherResponse: WeatherResponse? = WeatherResponse(coreData: firstcoreDatatem)
                print("DEBUG: getWeatherResponse from local core data \(String(describing: weatherResponse)) ")
                return .success(weatherResponse)
            }
            else {
                return .failure(CoreDataError.custom("Unexpected error occurred."))
            }
        }
        catch {
            print("DEBUG: Failed to load items with error \(error.localizedDescription)")
            return .failure(CoreDataError.custom("\(error.localizedDescription)"))
        }
    }
    
}
