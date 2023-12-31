//
//  Repo.swift
//  WeatherRepository
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation
import Combine

public protocol WeatherRepository {
    func getWeatherByCity(city: String) -> AnyPublisher<WeatherData, ProviderError>
    func getWeatherForecast(days: Int, city: String) -> AnyPublisher<[DayForcastDataModel], ProviderError>
    func searchForCities(city: String) -> AnyPublisher<[SearchDataModel] , ProviderError>
}
