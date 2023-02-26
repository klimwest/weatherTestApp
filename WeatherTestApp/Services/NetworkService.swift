//
//  NetworkService.swift
//  WeatherTestApp
//
//  Created by West on 26.02.23.
//

import Foundation
import CoreLocation

class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    let apiKey = "1aff3c61bab244259ff142401211709"
    
    func getWeather(location: CLLocationCoordinate2D, completion: @escaping (Weather) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(location.latitude),\(location.longitude)&aqi=no"
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } catch {
                print(error)
                return
            }
        }
        task.resume()
    }
}
