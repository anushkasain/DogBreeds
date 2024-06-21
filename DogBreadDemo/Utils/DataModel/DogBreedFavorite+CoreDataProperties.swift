//
//  DogBreedFavorite+CoreDataProperties.swift
//  
//
//  Created by Anushka Sain on 21/06/24.
//
//

import Foundation
import CoreData


extension DogBreedFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DogBreedFavorite> {
        return NSFetchRequest<DogBreedFavorite>(entityName: "DogBreedFavorite")
    }

    @NSManaged public var imageUrl: Data?
    @NSManaged public var name: String?

}
