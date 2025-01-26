//
//  WeatherResponse.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation


struct WeatherResponse: Codable, Equatable {
    
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    

    init?(coreData: WeatherCoreData) {
        self.id = Int(coreData.id)
        self.name = coreData.name ?? ""
        
        self.coord = Coord(lon: 0, lat: 0)
        self.weather = []
        self.base = ""
        self.main = Main(temp: 0, feelsLike: 0, tempMin: 0, tempMax: 0, pressure: 0, humidity: 0, seaLevel: 0, grndLevel: 0)
        self.visibility = 0
        self.wind = Wind(let: 0, deg: 0, gust: 0)
        self.clouds = Clouds(all: 0)
        self.dt = 0
        self.sys = Sys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0)
        self.timezone = 0
        self.cod = 0
    }
    
}


struct Clouds: Codable, Equatable {
    let all: Int
}


struct Coord: Codable, Equatable {
    let lon, lat: Double
}


struct Main: Codable, Equatable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}


struct Sys: Codable, Equatable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?    
}


struct Weather: Codable , Equatable{
    let id: Int
    let main, description, icon: String
}


struct Wind: Codable, Equatable {
    let speed: Double
    let deg: Int
    let gust: Double

    init(let speed: Double, deg: Int, gust: Double ) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
    
    enum CodingKeys: String, CodingKey {
        case speed, deg, gust
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        speed = try container.decode(Double.self, forKey: .speed)
        deg = try container.decode(Int.self, forKey: .deg)
        gust = try container.decodeIfPresent(Double.self, forKey: .gust) ?? 0.0
    }
}


struct ForecastResponse: Codable, Equatable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}


struct City: Codable, Equatable {
    let id: Int
    let name: String
    let coord: Coordd
    let country: String
    let population, timezone, sunrise, sunset: Int
}

struct Coordd: Codable, Equatable {
    let lat, lon: Double
}

struct List: Codable, Equatable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int? 
    let pop: Double
    let sys: Sys
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

struct MainClass: Codable, Equatable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Rain: Codable, Equatable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}


enum Pod: String, Codable, Equatable {
    case d = "d"
    case n = "n"
}


enum Description: String, Codable, Equatable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum MainEnum: String, Codable, Equatable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

