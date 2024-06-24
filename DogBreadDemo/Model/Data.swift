//
//  Data.swift
//   
//
//  Created by Anushka Sain on 20/06/24.
//  Copyright © 2024 DesarrolloManzana. All rights reserved.
//

import Foundation

public struct DogBreedsListModel: Codable {
    let message: [String: [String]]
    let status: String
}
public struct DogBreedsImageModel: Codable {
    let message: [String]
    let status: String
}

public struct FavoriteItem: Codable {
    let nameOfbread: String
    let imageUrlString: String
}
