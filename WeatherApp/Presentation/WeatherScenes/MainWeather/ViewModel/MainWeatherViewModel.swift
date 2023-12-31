//
//  MainWeatherViewModelViewModel.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation
import Combine
import SwiftUI

protocol MainWeatherViewModelModelOutput {
    var cityName: String { get }
    var date: String { get }
    var currentTime: String { get }
    var temp: String { get }
    var humidity: String { get }
    var windSpeed: String { get }
    var weatherStatus: String { get }
    var weatherImg: String { get }
    var feelsLikeInF: String { get }
    var daysData: [DayForcastDataModel] { get }
    var showAleart: Bool { get  set }
    var searchData: [SearchDataModel] { get }
}

protocol MainWeatherViewModelViewModelInput {
    func viewAppeared()
    func search(with city: String)
    func loadWeatherData(cityName: String)
}

protocol MainWeatherViewModel: ObservableObject, MainWeatherViewModelViewModelInput, MainWeatherViewModelModelOutput { }

final class DefaultMainWeatherViewModel: MainWeatherViewModel {
    
    //MARK: - Output Properties
    
    @Published var cityName: String = ""
    @Published var date: String = String()
    @Published var currentTime: String = String()
    @Published var temp: String = String()
    @Published var humidity: String = String()
    @Published var windSpeed: String = String()
    @Published var weatherStatus: String = String()
    @Published var weatherImg: String = String()
    @Published var feelsLikeInF: String = String()
    @Published var daysData: [DayForcastDataModel] = []
    @Published var showAleart: Bool = false
    @Published var searchData: [SearchDataModel] = []
    
    //MARK: - Private Properties
    
    private var weatherData: WeatherData! {
        didSet {
            self.cityName = weatherData.cityName
            self.date = weatherData.date
            self.currentTime = weatherData.time
            self.temp = weatherData.tempInF
            self.humidity = weatherData.humidity
            self.windSpeed = weatherData.windSpeedInMPH
            self.weatherStatus = weatherData.weatherStatus
            self.weatherImg = weatherData.weatherImg
            self.feelsLikeInF = weatherData.feelsLikeInF
        }
    }
    
    private var daysDataModels: [DayForcastDataModel] = [] {
        didSet {
            daysData.append(contentsOf: daysDataModels)
        }
    }
    
    private var searchDataModels: [SearchDataModel] = [] {
        didSet {
            self.searchData = searchDataModels
        }
    }
    
    private let fetchWeatherUseCase: FetchWeatherUseCase
    private let fetchWeatherForecastUseCase: FetchWeatherForecastUseCase
    private let searchForCitiesUseCase: SearchForCitiesUseCase
    private var cancellableBag = CancelBag()
    private var initiated = false
    
    //MARK: - Init
    
    init(fetchWeatherUseCase: FetchWeatherUseCase,
         fetchWeatherForecastUseCase: FetchWeatherForecastUseCase,
         searchForCitiesUseCase: SearchForCitiesUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
        self.fetchWeatherForecastUseCase = fetchWeatherForecastUseCase
        self.searchForCitiesUseCase = searchForCitiesUseCase
        
        bindLocationManager()
    }
    
    //MARK: - Priavte Functions
    
    private func loadWeatherDataWithDate(cityName: String) {
        fetchWeatherForecastUseCase.execute(days: 3, city: cityName)
            .sink { error in
                debugPrint(error)
            } receiveValue: {[weak self] weatherData in
                self?.daysData.removeAll()
                self?.daysDataModels = weatherData
            }.store(in: &cancellableBag)
    }
    
    private func bindLocationManager() {
        LocationManager.shared.$cityName.sink { [weak self] cityName in
            debugPrint(cityName)
            if cityName != "" && !self!.initiated {
                self?.loadWeatherData(cityName: cityName)
                self?.initiated = true
            }
        }.store(in: &cancellableBag)
    }
    
}

//MARK: - Inputs

extension DefaultMainWeatherViewModel {
    
    func viewAppeared() {
        LocationManager.shared.startLocationUpdate()
    }
}


//MARK: - Outputs

extension DefaultMainWeatherViewModel {
    
    func loadWeatherData(cityName: String) {
        loadWeatherDataWithDate(cityName: cityName)
        fetchWeatherUseCase.execute(city: cityName)
            .sink {  error in
                debugPrint(error)
            } receiveValue: { [weak self] weather in
                self?.weatherData = weather
                debugPrint(weather)
            }.store(in: &cancellableBag)
    }
    
    func search(with city: String) {
        searchForCitiesUseCase.search(city: city).sink { error in
            debugPrint(error)
        } receiveValue: {[weak self] searchData in
            self?.searchDataModels = searchData
        }.store(in: &cancellableBag)
    }
    
}
