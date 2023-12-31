//
//  AppDIContainer.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - DIContainers of scenes
    
    func makeWeatherScenesDiContainer() -> WeatherScenesDIContainer {
      return WeatherScenesDIContainer()
    }
    
}

