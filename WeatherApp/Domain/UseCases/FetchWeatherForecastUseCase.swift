//
//  FetchWeatherByDateUseCase.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation
import Combine

protocol FetchWeatherForecastUseCase {
    func execute(days: Int, city: String) -> AnyPublisher<[DayForcastDataModel], ProviderError>
}

final class DefaultFetchWeatherByDateUseCase: FetchWeatherForecastUseCase {

    //MARK: - Properties

    private let weatherRepository: WeatherRepository

    //MARK: - Init

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    //MARK: - Methods

    func execute(days: Int, city: String) -> AnyPublisher<[DayForcastDataModel], ProviderError> {
        weatherRepository.getWeatherForecast(days: days, city: city)
    }
    
}
