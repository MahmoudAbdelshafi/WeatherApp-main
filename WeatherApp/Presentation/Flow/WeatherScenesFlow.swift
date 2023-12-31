//
//  WeatherScenesCoordinator.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import UIKit

protocol WeatherScenesFlowCoordinatorDependencies {
    func makeMainWeatherHostingController() -> MainWeatherHostingController
}

final class WeatherScenesCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: WeatherScenesFlowCoordinatorDependencies
    
    private weak var mainWeatherVC: MainWeatherHostingController?
    
    init(navigationController: UINavigationController,
         dependencies: WeatherScenesFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let hostingController = dependencies.makeMainWeatherHostingController()
        navigationController?.pushViewController(hostingController, animated: false)
        mainWeatherVC = hostingController
    }

}
