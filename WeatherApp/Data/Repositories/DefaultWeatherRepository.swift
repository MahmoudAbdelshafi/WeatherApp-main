//
//  DefaultWeatherRepository.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation
import Combine

final class DefaultWeatherRepository {
    
    private let provider: Hover
    let pass = PassthroughSubject<WeatherData, Never>()
    
    init(provider: Hover) {
        self.provider = provider
    }
    
}

extension DefaultWeatherRepository: WeatherRepository {
    
    func getWeatherByCity(city: String) -> AnyPublisher<WeatherData, ProviderError> {
        provider.request(
            with: WeatherTarget.currentWatherData(city: city),
            scheduler: DispatchQueue.main,
            class: WeatherDataResponseDTO.self
        )
        .map{ $0.toWeatherDataDomain() }
        .eraseToAnyPublisher()
    }
    
    
    func getWeatherForecast(days: Int, city: String) -> AnyPublisher<[DayForcastDataModel] , ProviderError> {
        provider.request(
            with: WeatherTarget.watherForecast(days: days, city: city),
            scheduler: DispatchQueue.main,
            class: WatherForecastResponseDTO.self
        )
        .map { $0.toDomain() }
        .eraseToAnyPublisher()
    }
    
    func searchForCities(city: String) -> AnyPublisher<[SearchDataModel] , ProviderError> {
        provider.request(
            with: WeatherTarget.searchForCity(city: city),
            scheduler: DispatchQueue.main,
            class: SearchResponseArray.self
        )
        .map { $0.toDomain() }
        .eraseToAnyPublisher()
    }
}
