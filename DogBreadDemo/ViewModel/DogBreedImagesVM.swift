//
//  DogBreedImagesVM.swift
//
//
//  Created by Anushka Sain on 20/06/24.
//  Copyright © 2024 DesarrolloManzana. All rights reserved.
//

import Foundation

struct DogItem {
    var isSelect: Bool
    let imageUrl: String
}

class DogBreedImagesVM: FavouriteDogBreedsImageProtocol {
    
    var reloadCollectionView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    var dogBreedImages: [DogItem] = []
    var selecteddogBreedTitle: String
    private let networkManager = NetworkManager.shared
    
    /// initialize VM with selected dog breed
    /// - Parameter selecteddogBreedTitle: selected Dog breed from previous screen
    init(selecteddogBreedTitle: String) {
        self.selecteddogBreedTitle = selecteddogBreedTitle
    }
    
    /// Fetch Bread Image Api
    func fetchBreedImagesFromApi() {
        let endpoint = APIConstants.Endpoints.breedImages.replacingOccurrences(of: "{breed}", with: selecteddogBreedTitle)
        showLoading?()
        networkManager.getRequest(apiEndPoint: endpoint, responseType: DogBreedsImageModel.self) { result in
            do {
                switch result {
                case .success(let dogBreedsImageModel):
                    if dogBreedsImageModel.message.count > 0 {
                        self.dogBreedImages = dogBreedsImageModel.message.map { item in
                            return DogItem(isSelect: false, imageUrl: item)
                        }
                    }
                    self.matchDataAndSetFavorite(dogItems: self.dogBreedImages, localSearchgData: self.retriveDataFromLocalStorage())
                    self.reloadCollectionView?()
                case .failure(let error):
                    throw error
                }
                self.hideLoading?()
            } catch {
                print("Error: \(error.localizedDescription)")
                print("Failed to fetch dog breeds:", error)
                self.hideLoading?()
                self.showError?()
            }
        }
    }
     
    /// Returns the number of dog breed images.
    var numberOfCells: Int {
        return dogBreedImages.count
    }
    
    /// Retrieves the image URL for a given index.
    /// - Parameter index: The index of the image.
    /// - Returns: The URL of the dog breed image.
    func dogBreedImage(for index: Int) -> String {
        return dogBreedImages[index].imageUrl
    }
    
    /// Checks if a dog breed image is selected at a specific index.
    /// - Parameter index: The index to check.
    /// - Returns: `true` if the image is selected, `false` otherwise.
    func dogBreedIsSelect(on index: Int) -> Bool {
        return dogBreedImages[index].isSelect
    }
    
    /// Updates the selection status of a dog breed image and manages UserDefaults accordingly.
    /// - Parameters:
    ///   - index: The index of the image to update.
    ///   - isSelect: The new selection status (`true` for selected, `false` for deselected).
    func favOrUnFavUpdateInDogBreed(index: Int, isSelect: Bool) {
        dogBreedImages[index].isSelect = isSelect
        if isSelect {
            addValueToBreed(key: selecteddogBreedTitle, value: dogBreedImages[index].imageUrl)
        }else{
            removeValueFromBreed(key: selecteddogBreedTitle, value: dogBreedImages[index].imageUrl)
        }
    }
    
    func retriveDataFromLocalStorage() -> [String: [String]] {
        return retrieveBreedsDictionary(key: "dogBreed")
    }
    
    /// Retrieves a dictionary of dog breeds and their associated image URLs from UserDefaults.
    /// - Parameter key: The key to retrieve the dictionary from UserDefaults.
    /// - Returns: A dictionary mapping dog breed names to arrays of image URLs.
    func retrieveBreedsDictionary(key: String) -> [String: [String]] {
        return UserDefaultManager.retrieveBreedsDictionary(forKey: key)
    }
    
    func matchDataAndSetFavorite(dogItems: [DogItem], localSearchgData: [String: [String]]){
        if let urlsForTitle = localSearchgData[selecteddogBreedTitle] {
            // 2. Iterate through dogItems and update isSelect based on URL match
           let  dogItems = dogItems.map { item in
                var updatedItem = item
                if urlsForTitle.contains(item.imageUrl) {
                    updatedItem.isSelect = true
                }
                return updatedItem
            }
            self.dogBreedImages = dogItems
        }
    }
}
