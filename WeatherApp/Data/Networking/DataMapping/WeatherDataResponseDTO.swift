//
//  WeatherDataResponseDTO.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation


// MARK: - WeatherData
struct WeatherDataResponseDTO: Codable {
    let location: Location?
    let current: Current?
}

// MARK: - Current

struct Current: Codable {
    let lastUpdatedEpoch: Int?
    let lastUpdated: String?
    let tempF: Double?
    let condition: Condition?
    let windMph: Double?
    let humidity: Int?
    let feelslikeF: Double?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempF = "temp_f"
        case condition
        case windMph = "wind_mph"
        case humidity
        case feelslikeF = "feelslike_f"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String?
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let localtime: String?
}


//MARK: - WeatherDataResponseDTO To Domain

extension WeatherDataResponseDTO {
    func toWeatherDataDomain() -> WeatherData {
        
        let dateFormate = WeatherDateFormatter.date(from: self.location?.localtime ?? "",with: .yyyyDashMMDashdd) ?? Date()
        let time = WeatherDateFormatter.formate(date: dateFormate, with: .time)
        let date = WeatherDateFormatter.formate(date: dateFormate, with: .EEEEddMMMMyyy)
        
        let weatherImg = "https:" + (self.current?.condition?.icon ?? "")
        
        let weatherData = WeatherData(cityName: self.location?.name ?? "",
                                      date: date,
                                      time: time,
                                      weatherImg: weatherImg,
                                      tempInF: "\(current?.tempF ?? 0.0)°",
                                      weatherStatus: self.current?.condition?.text ?? "",
                                      humidity: "\(current?.humidity ?? 0)",
                                      windSpeedInMPH: "\(current?.windMph ?? 0.0)",
                                      feelsLikeInF: "\(current?.feelslikeF ?? 0.0)°")
        return weatherData
    }
    
}
