//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Mahmoud Abdelshafi on 30/12/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
      
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true

        window?.rootViewController = navigationController
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController,
                                                appDIContainer: appDIContainer)
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
    }

}
