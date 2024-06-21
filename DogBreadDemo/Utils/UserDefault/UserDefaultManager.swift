//
//  UserDefault.swift
//  DogBreadDemo
//
//  Created by Anushka Sain on 21/06/24.
//

import Foundation

struct UserDefaultManager {
    
    static func getValue(forKey key: String) -> [String: [String]] {
        let defaults = UserDefaults.standard
        return defaults.dictionary(forKey: key) as? [String: [String]] ?? [:]
    }
    
    static func setValue(_ value: [String: [String]], forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func retrieveBreedsDictionary(forKey key: String) -> [String: [String]] {
        let defaults = UserDefaults.standard
        return defaults.dictionary(forKey: key) as? [String: [String]] ?? [:]
    }
    
}

