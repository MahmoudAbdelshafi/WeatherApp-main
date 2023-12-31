//
//  WatherDataByDateResponseDTO.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation

// MARK: - WatherDataByDateResponseDTO

struct WatherForecastResponseDTO: Codable {
    let forecast: Forecast?
    let current: Current?
}

// MARK: - Forecast

struct Forecast: Codable {
    let forecastday: [Forecastday]?
}
// MARK: - Forecastday

struct Forecastday: Codable {
    let date: String?
    let hour: [Hour]?
    
    enum CodingKeys: String, CodingKey {
        case date
        case hour
    }
}

// MARK: - Hour

struct Hour: Codable {
    let time: String?
    let tempF: Double?
    let feelslikeF: Double?
    let condition: Condition?
    
    enum CodingKeys: String, CodingKey {
        case time, condition
        case tempF = "temp_f"
        case feelslikeF = "feelslike_f"
        
    }
}


//MARK: - WatherDataByDateResponseDTO To Domain

extension WatherForecastResponseDTO {
    
    func toDomain() -> [DayForcastDataModel] {
        
        var daysDataModels: [DayForcastDataModel] = []
        let forecastday = self.forecast?.forecastday
        let https = "https:"
        
        let tomorrowsForcast = forecastday?.first(where: { $0.date == getCurrentDate(plusDays: 1) } )
        
        let fridayForcast = forecastday?.first(where: { $0.date == getCurrentDate(plusDays: 2) } )
        
        
        let todaysDataModel = DayForcastDataModel(image: https + (self.current?.condition?.icon ?? "") ,
                                                  temp:  "\(self.current?.tempF ?? 0.0)",
                                                  feelsLikeInF: "\(self.current?.feelslikeF ?? 0.0)°",
                                                  dayName: "Today")
        
        let tomorrowDataModel = DayForcastDataModel(image: https + (tomorrowsForcast?.hour?.first?.condition?.icon ?? "") ,
                                                  temp:  "\(tomorrowsForcast?.hour?.first?.tempF ?? 0.0)",
                                                  feelsLikeInF: "\(tomorrowsForcast?.hour?.first?.feelslikeF ?? 0.0)°",
                                                  dayName: "Tomorrow")
        
        
        let fridayDataModel = DayForcastDataModel(image: https + (fridayForcast?.hour?.last?.condition?.icon ?? ""),
                                                temp:  "\(fridayForcast?.hour?.last?.tempF ?? 0.0)",
                                                feelsLikeInF: "\(fridayForcast?.hour?.last?.feelslikeF ?? 0.0)°",
                                                dayName: "Friday")
        
        daysDataModels = [todaysDataModel ,tomorrowDataModel, fridayDataModel]
        return daysDataModels
    }
    /// Date EX: - 2022-11-02 
    private func getCurrentDate(plusDays: Int = 0) -> String {
        var dayComponent    = DateComponents()
        dayComponent.day    = plusDays
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date()) ?? Date()
        return WeatherDateFormatter.formate(date: nextDate, with: .yyyyMMdd)
    }
}
