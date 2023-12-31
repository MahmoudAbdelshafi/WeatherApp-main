//
//  FetchWeatherUseCase.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation
import Combine

protocol FetchWeatherUseCase {
    func execute(city: String) -> AnyPublisher<WeatherData, ProviderError>
}

public final class DefaultFetchWeatherUseCase: FetchWeatherUseCase {

    //MARK: - Properties

    private let weatherRepository: WeatherRepository

    //MARK: - Init

    public init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    //MARK: - Methods

   public func execute(city: String) -> AnyPublisher<WeatherData, ProviderError> {
        weatherRepository.getWeatherByCity(city: city)
    }
    
}
