//
//  DogBreedListVM.swift
//
//  Created by Anushka Sain on 20/06/24.
//  Copyright © 2024 DesarrolloManzana. All rights reserved.
//

import UIKit

class DogBreedListVM {
    
    // MARK: - Properties
    
    var reloadTableView: (() -> Void)?
    var showError: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var dogBreeds: [String: [String]] = [:]
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public Functions
    
    /// Fetches the list of dog breeds from an API endpoint.
    func fetchDogsBreedListFromApi() {
        showLoading?()
        networkManager.getRequest(apiEndPoint: APIConstants.Endpoints.listAllBreeds, responseType: DogBreedsListModel.self) { result in
            do {
                switch result {
                case .success(let dogBreedsListModel):
                    self.dogBreeds = dogBreedsListModel.message
                    self.reloadTableView?()
                    self.hideLoading?()
                    
                case .failure(let error):
                    throw error // Throw the error to catch block
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                self.hideLoading?()
                self.showError?()
            }
        }
    }
    
    /// Returns the number of dog breeds.
    var numberOfCells: Int {
        return dogBreeds.keys.count
    }
    
    /// Retrieves the name of a dog breed for a specific index.
    /// - Parameter index: The index of the dog breed.
    /// - Returns: The name of the dog breed.
    func breedName(for index: Int) -> String {
        return Array(dogBreeds.keys).sorted()[index]
    }
}
