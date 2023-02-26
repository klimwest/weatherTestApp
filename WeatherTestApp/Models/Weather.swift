//
//  Weather.swift
//  WeatherTestApp
//
//  Created by West on 26.02.23.
//

import Foundation

struct Weather: Codable {
    let location: Location?
    let current: Current?
    
    struct Location: Codable {
        let name: String?
    }
    
    struct Current: Codable {
        let temp_c: Double?
    }
    
    static let `default` = Weather(location: nil, current: nil)
}
