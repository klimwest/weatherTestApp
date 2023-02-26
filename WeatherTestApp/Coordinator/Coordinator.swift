//
//  Coordinator.swift
//  WeatherTestApp
//
//  Created by West on 26.02.23.
//

import UIKit
import CoreLocation

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    
    private let localStorage = LocalStorageService()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if localStorage.getTutorialStatus() {
            let vc = WeatherViewController(location: nil)
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        } else {
            let vc = TutorialViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func goToLoadingScreen() {
        let vc = LoaderViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToWeatherScreen(location: CLLocationCoordinate2D) {
        let vc = WeatherViewController(location: location)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
