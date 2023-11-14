//
//  AnimalsEndpoint.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

struct AnimalsEndpoint {
    static func fetchAnimal(name: String) -> APIEndpoint<[AnimalResponseDTO]> {
        return APIEndpoint(
            path: APIConfig.Ninja.animals,
            useBaseURL: false,
            method: .get,
            headers: ["X-Api-Key": APIConfig.Ninja.apiKey],
            queryParameters: ["name": name]
        )
    }
}
