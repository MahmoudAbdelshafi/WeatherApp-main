//
//  WeatherTarget.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import Foundation

enum WeatherTarget {
    
    case currentWatherData(city: String)
    case watherForecast(days: Int, city: String)
    case searchForCity(city: String)
}

extension WeatherTarget: NetworkTarget {
   
    private var v1: String { "v1/" }
    
    var path: String {
        switch self {
        case .currentWatherData:
            return v1 + "current.json"
            
        case .watherForecast:
            return v1 + "forecast.json"
            
        case .searchForCity:
            return v1 + "search.json"
        }
    }
    
    var methodType: MethodType {
        
        switch self {
        case .currentWatherData, .watherForecast, .searchForCity:
            return .get
        }
    }

    var workType: WorkType {
        switch self {
        case .currentWatherData(let city), .searchForCity(let city):
            return .requestParameters(parameters: ["q"  : city] )
            
        case .watherForecast(let days, let city):
            return .requestParameters(parameters: ["q"  : city,
                                                   "days"   : "\(days)",
                                                   "aqi"    : "no",
                                                   "alerts" : "no" ] )
        }
    }
    
    var providerType: AuthProviderType {
        switch self {
        case .currentWatherData, .watherForecast, .searchForCity:
            return .none
        }
    }
    
    var contentType: ContentType? {
        switch self {
        case .currentWatherData, .watherForecast, .searchForCity:
            return .applicationJson
        }
    }
    
}
