//
//  LocalStorageService.swift
//  WeatherTestApp
//
//  Created by West on 26.02.23.
//

import Foundation

final class LocalStorageService {
    enum Constants: String {
        case tutorialStatus
    }

    func getTutorialStatus() -> Bool {
        UserDefaults.standard.bool(forKey: Constants.tutorialStatus.rawValue)
    }

    func saveTutorialStatus(status: Bool) {
        UserDefaults.standard.set(status, forKey: Constants.tutorialStatus.rawValue)
    }
}
