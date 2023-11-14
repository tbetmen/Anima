//
//  PhotosEndpoint.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

struct PhotosEndpoint {
    static func fetchPhotos(
        name: String
    ) -> APIEndpoint<PhotosResponseDTO> {
        return APIEndpoint(
            path: APIConfig.Pexels.search,
            useBaseURL: false,
            method: .get,
            headers: ["Authorization": APIConfig.Pexels.apiKey],
            queryParameters: [
                "query": name,
                "per_page": 20,
            ]
        )
    }
}
