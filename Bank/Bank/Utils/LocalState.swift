//
//  LocalState.swift
//  bank
//
//  Created by Sunggon Park on 2024/03/25.
//
import Foundation

class LocalState {
    private enum Keys: String {
        case hasOnboarded
    }
    
    static var hasOnboarded: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.hasOnboarded.rawValue)
        }
    }
}
