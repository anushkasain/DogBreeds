//
//  ApiUrls.swift
//  DogBreadDemo
//
//  Created by Anushka Sain on 20/06/24.
//

import Foundation

struct APIConstants {
    // Base URL for the API
    static let baseURL = "https://dog.ceo/api"
    
    // Endpoints
    struct Endpoints {
        static let listAllBreeds = "/breeds/list/all"
        static let breedImages = "/breed/{breed}/images"
        // Add more endpoints as needed
    }
    // Function to construct full URLs
    static func fullURL(for endpoint: String) -> String {
        return baseURL + endpoint
    }
}
