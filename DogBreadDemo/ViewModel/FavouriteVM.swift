//
//  FavouriteVM.swift
//  DogBreadDemo
//
//  Created by Anushka Sain on 20/06/24.
//

import Foundation

class FavouriteVM {
    var favDogsBreedList: [String: [String]] = [:]
    var favDogsImagesList: [FavoriteItem] = []
    var reloadCollectionView: (()->())?
    
    /// Retrieves all dog breeds and their associated image URLs from UserDefaults.
    func retriveAllDogsBreedFromUserDefault() {
        let dogBreedsList = retrieveBreedsDictionary(key: "dogBreed")
        self.favDogsBreedList = dogBreedsList
        self.favDogsImagesList = retriveAllFavDogs(favDogsBreedList: self.favDogsBreedList)
        self.reloadCollectionView?()
    }
    
    /// Retrieves a dictionary of dog breeds and their associated image URLs from UserDefaults.
    /// - Parameter key: The key to retrieve the dictionary from UserDefaults.
    /// - Returns: A dictionary mapping dog breed names to arrays of image URLs.
    func retrieveBreedsDictionary(key: String) -> [String: [String]] {
        UserDefaultManager.retrieveBreedsDictionary(forKey: key)
    }
    
    /// Converts a dictionary of favorite dog breeds and their image URLs into an array of FavoriteItem objects.
    /// - Parameter favDogsBreedList: The dictionary of favorite dog breeds and their image URLs.
    /// - Returns: An array of FavoriteItem objects representing the favorite dog breeds and their image URLs.
    func retriveAllFavDogs(favDogsBreedList: [String: [String]]) -> [FavoriteItem] {
        let dogBreedImages: [FavoriteItem] = favDogsBreedList.flatMap { breed, imageUrls in
            imageUrls.map { imageUrl in
                FavoriteItem(nameOfbread: breed, imageUrlString: imageUrl)
            }
        }
        print("retrive all:", dogBreedImages)
        return dogBreedImages
    }
    
    /// Retrieves the image URL string for a specific index in the list of favorite dog breed images.
    /// - Parameter index: The index of the image URL string to retrieve.
    /// - Returns: The image URL string.
    func dogBreedImage(for index: Int) -> String {
        return favDogsImagesList[index].imageUrlString
    }
    
    /// Retrieves a filtered list of dog breed names for use in filtering favorite dog breed images.
    /// - Returns: An array of dog breed names, including "Filter by breed" as the first item followed by sorted breed names.
    func getFilterList() -> [String] {
        let breedKeys = Array(favDogsBreedList.keys).sorted()
        var filterArray = ["Filter by breed"]
        filterArray.append(contentsOf: breedKeys)
        return filterArray
    }
    
    /// Filters the list of favorite dog breed images based on a given dog breed name.
    /// - Parameter title: The title (dog breed name) to filter by. If "Filter by breed", retrieves all favorite dog breed images.
    func filterDataOnDogBreed(title: String) {
        if title == "Filter by breed" {
            favDogsImagesList = retriveAllFavDogs(favDogsBreedList: self.favDogsBreedList)
        } else {
            favDogsImagesList = retriveAllFavDogs(favDogsBreedList: filterBreedsContaining(breed: title, from: favDogsBreedList))
        }
    }
    
    /// Filters a dictionary of dog breeds and their associated image URLs to include only those containing a specific breed name.
    /// - Parameters:
    ///   - breed: The breed name to filter by.
    ///   - dictionary: The dictionary of dog breeds and their associated image URLs.
    /// - Returns: A filtered dictionary containing only the dog breeds that match the specified breed name.
    func filterBreedsContaining(breed: String, from dictionary: [String: [String]]) -> [String: [String]] {
        return dictionary.filter { (key, _) in
            return key.contains(breed)
        }
    }
}
