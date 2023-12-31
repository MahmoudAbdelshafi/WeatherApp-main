//
//  DefaultMainWeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mahmoud Abdelshafi on 31/12/2023.
//

import XCTest
import Combine
@testable import WeatherApp

class DefaultMainWeatherViewModelTests: XCTestCase {

    var viewModel: DefaultMainWeatherViewModel!
    var fetchWeatherUseCase: MockFetchWeatherUseCase!
    var fetchWeatherForecastUseCase: MockFetchWeatherForecastUseCase!
    var searchForCitiesUseCase: MockSearchForCitiesUseCase!
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        fetchWeatherUseCase = MockFetchWeatherUseCase()
        fetchWeatherForecastUseCase = MockFetchWeatherForecastUseCase()
        searchForCitiesUseCase = MockSearchForCitiesUseCase()

        viewModel = DefaultMainWeatherViewModel(
            fetchWeatherUseCase: fetchWeatherUseCase,
            fetchWeatherForecastUseCase: fetchWeatherForecastUseCase,
            searchForCitiesUseCase: searchForCitiesUseCase
        )
    }

    override func tearDownWithError() throws {
        cancellables.forEach { $0.cancel() }
    }

    // MARK: - Test Cases

    func testLoadWeatherData() {
        // Given
        let cityName = "TestCity"
        let expectedWeatherData = WeatherData(
            cityName: "TestCity",
            date: "2023-01-01",
            time: "12:00 PM",
            weatherImg: "cloudy.png",
            tempInF: "72°F",
            weatherStatus: "Cloudy",
            humidity: "60%",
            windSpeedInMPH: "15 MPH",
            feelsLikeInF: "75°F"
        )

        fetchWeatherUseCase.stubbedExecuteResult = Result.Publisher(.success(expectedWeatherData)).eraseToAnyPublisher()

        // When
        viewModel.loadWeatherData(cityName: cityName)

        // Then
        XCTAssertEqual(viewModel.cityName, expectedWeatherData.cityName)

    }

    func testSearch() {
        // Given
        let city = "TestCity"
        let expectedSearchData = [
            SearchDataModel(name: "City1", region: "Region1", country: "Country1"),
            SearchDataModel(name: "City2", region: "Region2", country: "Country2"),
            // Add more instances with different data for additional test cases
        ]
        searchForCitiesUseCase.stubbedSearchResult = Result.Publisher(.success(expectedSearchData)).eraseToAnyPublisher()

        // When
        viewModel.search(with: city)

        // Then
        XCTAssertEqual(viewModel.searchData, expectedSearchData)
    }

}

class MockFetchWeatherUseCase: FetchWeatherUseCase {

    var stubbedExecuteResult: AnyPublisher<WeatherData, ProviderError>!

    func execute(city: String) -> AnyPublisher<WeatherData, ProviderError> {
        return stubbedExecuteResult
    }
}


class MockFetchWeatherForecastUseCase: FetchWeatherForecastUseCase {

    var stubbedExecuteResult: AnyPublisher<[DayForcastDataModel], ProviderError> = Result.Publisher(.failure(.invalidServerResponse)).eraseToAnyPublisher()

    func execute(days: Int, city: String) -> AnyPublisher<[DayForcastDataModel], ProviderError> {
        return stubbedExecuteResult
    }
}



class MockSearchForCitiesUseCase: SearchForCitiesUseCase {

    var stubbedSearchResult: AnyPublisher<[SearchDataModel], ProviderError>!

    func search(city: String) -> AnyPublisher<[SearchDataModel], ProviderError> {
        return stubbedSearchResult
    }
}
