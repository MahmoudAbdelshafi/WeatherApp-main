//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation

public struct WeatherData: Equatable {
    let cityName: String
    let date: String
    let time: String
    let weatherImg: String
    let tempInF: String
    let weatherStatus: String
    let humidity: String
    let windSpeedInMPH: String
    let feelsLikeInF: String
    
    public init(cityName: String,
                date: String,
                time: String,
                weatherImg: String,
                tempInF: String,
                weatherStatus: String,
                humidity: String,
                windSpeedInMPH: String,
                feelsLikeInF: String) {
        self.cityName = cityName
        self.date = date
        self.time = time
        self.weatherImg = weatherImg
        self.tempInF = tempInF
        self.weatherStatus = weatherStatus
        self.humidity = humidity
        self.windSpeedInMPH = windSpeedInMPH
        self.feelsLikeInF = feelsLikeInF
    }
}
