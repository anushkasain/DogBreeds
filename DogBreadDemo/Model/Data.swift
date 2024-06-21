//
//  Data.swift
//   
//
//  Created by Antonio Corrales on 26/6/18.
//  Copyright © 2018 DesarrolloManzana. All rights reserved.
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
