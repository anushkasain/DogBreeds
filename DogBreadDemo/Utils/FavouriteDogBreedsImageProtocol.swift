//
//  FavouriteDogBreedsImageProtocol.swift
//  DogBreadDemo
//
//  Created by Anushka Sain on 21/06/24.
//

import Foundation

protocol FavouriteDogBreedsImageProtocol {
    func removeValueFromBreed(key: String, value: String)
    func addValueToBreed(key: String, value: String)
}

extension FavouriteDogBreedsImageProtocol {
    func removeValueFromBreed(key: String, value: String) {
        // Retrieve the existing dictionary from UserDefaults
        var breedsDictionary: [String: [String]] = UserDefaultManager.getValue(forKey: "dogBreed")
        
        // Get the existing array for the key
        if var breedArray = breedsDictionary[key] {
            // Remove the specified value from the array
            breedArray.removeAll { $0 == value }
            
            // If the array is empty after removal, you may choose to remove the key as well
            if breedArray.isEmpty {
                breedsDictionary.removeValue(forKey: key)
            } else {
                // Update the array in the dictionary
                breedsDictionary[key] = breedArray
            }
        }
        
        // Save the updated dictionary back to UserDefaults
        UserDefaultManager.setValue(breedsDictionary, forKey: "dogBreed")
    }
    
    func addValueToBreed(key: String, value: String) {
        // Retrieve the existing dictionary from UserDefaults
        var breedsDictionary: [String: [String]] = UserDefaultManager.getValue(forKey: "dogBreed")
        
        // Get the existing array for the key or create a new one if it doesn't exist
        var breedArray: [String] = breedsDictionary[key] ?? []
        
        // Add the new value to the array if it's not already present
        if !breedArray.contains(value) {
            breedArray.append(value)
        }
        
        // Update the dictionary with the new array
        breedsDictionary[key] = breedArray
        
        // Save the updated dictionary back to UserDefaults
        UserDefaultManager.setValue(breedsDictionary, forKey: "dogBreed")
    }
}
