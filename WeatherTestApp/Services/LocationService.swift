//
//  LocationService.swift
//  WeatherTestApp
//
//  Created by West on 26.02.23.
//

import CoreLocation
import Foundation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    func getUserLocation(completion: @escaping ((CLLocation?) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
    }
    
}
