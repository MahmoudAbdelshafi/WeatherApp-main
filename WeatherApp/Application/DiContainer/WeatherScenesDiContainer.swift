//
//  WeatherScenesDiContainer.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import UIKit

final class WeatherScenesDIContainer {
    
    // MARK: - Repositories
    
    func makeDefaultWeatherRepository() -> WeatherRepository {
        DefaultWeatherRepository(provider: Hover())
    }
    
    // MARK: - Use Cases
    
    func makeDefaultFetchWeatherUseCase() -> FetchWeatherUseCase {
        DefaultFetchWeatherUseCase(weatherRepository: makeDefaultWeatherRepository())
    }
    
    func makeDefaultFetchWeatherByDateUseCase() -> FetchWeatherForecastUseCase {
        DefaultFetchWeatherByDateUseCase(weatherRepository: makeDefaultWeatherRepository())
    }
    
    func makeDefaultSearchForCitiesUseCase() -> SearchForCitiesUseCase {
        DefaultSearchForCitiesUseCase(weatherRepository: makeDefaultWeatherRepository())
    }
    
    //MARK: - ViewModels
    
    func makeDefaultMainWeatherViewModel(fetchWeatherUseCase: FetchWeatherUseCase) -> DefaultMainWeatherViewModel {
        DefaultMainWeatherViewModel(fetchWeatherUseCase: makeDefaultFetchWeatherUseCase(),
                                    fetchWeatherForecastUseCase: makeDefaultFetchWeatherByDateUseCase(),
                                    searchForCitiesUseCase: makeDefaultSearchForCitiesUseCase())
    }
}

// MARK: - WeatherScenesRouter Dependencies

extension WeatherScenesDIContainer: WeatherScenesFlowCoordinatorDependencies {
    
    func makeMainWeatherHostingController() -> MainWeatherHostingController {
        let viewModel = makeDefaultMainWeatherViewModel(fetchWeatherUseCase: makeDefaultFetchWeatherUseCase())
        return MainWeatherHostingController(rootView: MainView(viewModel: viewModel))
    }
 
    func makeWeatherScenesRouter(navigationController: UINavigationController) -> WeatherScenesCoordinator {
        WeatherScenesCoordinator(navigationController: navigationController, dependencies: self)
    }
    
}
