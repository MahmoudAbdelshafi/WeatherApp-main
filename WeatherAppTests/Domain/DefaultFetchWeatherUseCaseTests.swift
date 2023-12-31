//
//  DefaultFetchWeatherUseCaseTests.swift
//  WeatherAppTests
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation
import XCTest
import Combine
import WeatherApp

class DefaultFetchWeatherUseCaseTests: XCTestCase {

    // MARK: - Properties
    
    var sut: DefaultFetchWeatherUseCase!
    var mockRepository: MockWeatherRepository!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        mockRepository = MockWeatherRepository()
        sut = DefaultFetchWeatherUseCase(weatherRepository: mockRepository)
    }

    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }

    // MARK: - Test Cases
    
    func testFetchWeatherByCitySuccess() {
        // Given
        let city = "TestCity"
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

        mockRepository.stubbedGetWeatherByCityResult = Result.Publisher(.success(expectedWeatherData)).eraseToAnyPublisher()

        // When
        let expectation = XCTestExpectation(description: "Fetch weather by city success")
        var receivedWeatherData: WeatherData?

        _ = sut.execute(city: city)
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: { weatherData in
                receivedWeatherData = weatherData
            })

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedWeatherData, expectedWeatherData, "Weather data should match the expected result")
    }

    func testFetchWeatherByCityFailure() {
        // Given
        let city = "TestCity"
        let expectedError = ProviderError.failedToDecodeImage
        mockRepository.stubbedGetWeatherByCityResult = Result.Publisher(.failure(expectedError)).eraseToAnyPublisher()

        // When
        let expectation = XCTestExpectation(description: "Fetch weather by city failure")
        var receivedError: ProviderError?

        _ = sut.execute(city: city)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error
                }
                expectation.fulfill()
            }, receiveValue: { _ in })

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedError, expectedError, "Error should match the expected result")
    }
}

// MARK: - MockWeatherRepository

class MockWeatherRepository: WeatherRepository {
    
    var stubbedGetWeatherByCityResult: AnyPublisher<Result<WeatherData, ProviderError>, Never>!
    var stubbedGetWeatherForecastResult: AnyPublisher<Result<[DayForcastDataModel], ProviderError>, Never>!
    var stubbedSearchForCitiesResult: AnyPublisher<Result<[SearchDataModel], ProviderError>, Never>!

    func getWeatherByCity(city: String) -> AnyPublisher<WeatherData, ProviderError> {
        return stubbedGetWeatherByCityResult
            .flatMap { result -> AnyPublisher<WeatherData, ProviderError> in
                switch result {
                case .success(let data):
                    return Just(data)
                        .setFailureType(to: ProviderError.self)
                        .eraseToAnyPublisher()
                case .failure(let error):
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    func getWeatherForecast(days: Int, city: String) -> AnyPublisher<[DayForcastDataModel], ProviderError> {
        return stubbedGetWeatherForecastResult
            .flatMap { result -> AnyPublisher<[DayForcastDataModel], ProviderError> in
                switch result {
                case .success(let data):
                    return Just(data)
                        .setFailureType(to: ProviderError.self)
                        .eraseToAnyPublisher()
                case .failure(let error):
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    func searchForCities(city: String) -> AnyPublisher<[SearchDataModel], ProviderError> {
        return stubbedSearchForCitiesResult
            .flatMap { result -> AnyPublisher<[SearchDataModel], ProviderError> in
                switch result {
                case .success(let data):
                    return Just(data)
                        .setFailureType(to: ProviderError.self)
                        .eraseToAnyPublisher()
                case .failure(let error):
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}


