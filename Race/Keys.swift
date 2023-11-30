//
//  Keys.swift
//  Race
//
//  Created by Alina Sakovskaya on 7.09.23.
//

import Foundation


enum Keys {
    
    static let gameSettings: String = "settings"
    static let settingsForTableView: String = "settingsForTableView"
    
}

enum GameLevel: Int {
case easy
case medium
case hard
    
    func getSpeed() -> Double {
        switch self {
        case .easy:
            return 1.6
        case .medium:
            return 1.0
        case .hard:
            return 0.7
        }
    }
    
}


