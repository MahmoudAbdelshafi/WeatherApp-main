//
//  SearchForCitiesUseCase.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation
import Combine

protocol SearchForCitiesUseCase {
    func search(city: String) -> AnyPublisher<[SearchDataModel] , ProviderError>
}

final class DefaultSearchForCitiesUseCase: SearchForCitiesUseCase {

    //MARK: - Properties

    private let weatherRepository: WeatherRepository

    //MARK: - Init

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    //MARK: - Methods

    func search(city: String) -> AnyPublisher<[SearchDataModel] , ProviderError> {
        weatherRepository.searchForCities(city: city)
    }
    
}
