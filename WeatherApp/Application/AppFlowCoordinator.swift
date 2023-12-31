//
//  AppFlowCoordinator.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let weatherScenesDIContainer = appDIContainer.makeWeatherScenesDiContainer()
        let flow = weatherScenesDIContainer.makeWeatherScenesRouter(navigationController: navigationController)
        flow.start()
    }
}
