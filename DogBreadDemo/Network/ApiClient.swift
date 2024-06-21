//
//  DogBreedController.swift
//
//
//  Created by Anushka Sain on 20/06/24.
//  Copyright © 2024 DesarrolloManzana. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {} // Prevent others from using the default '()' initializer
    
    /// Performs a GET request to a specified API endpoint.
    ///
    /// - Parameters:
    ///   - apiEndPoint: The endpoint to which the GET request is made.
    ///   - parameters: Optional parameters to be sent with the request.
    ///   - responseType: The type of response expected from the server, conforming to `Decodable`.
    ///   - completion: Closure called upon completion of the request with a `Result` containing either the decoded response or an error.
    func getRequest<T: Decodable>(apiEndPoint: String, parameters: [String: Any]? = nil, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let url = APIConstants.fullURL(for: apiEndPoint)
        
        AF.request(url, method: .get, parameters: parameters)
            .validate() // Validate the response to ensure it is successful (status code in range 200-299)
            .responseDecodable(of: responseType) { response in
                switch response.result {
                case .success(let decodedResponse):
                    completion(.success(decodedResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
