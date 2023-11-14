//
//  PhotosResponseDTO.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

struct PhotosResponseDTO: Decodable {
    var photos = [Photo]()
    
    struct Photo: Decodable {
        let id: Int
        var src = Src(portrait: "")
    }
    
    struct Src: Decodable {
        let portrait: String
    }
}

extension PhotosResponseDTO {
    func toEntity(name: String) -> [AnimalPhoto] {
        self.photos.map {
            return AnimalPhoto(
                id: $0.id,
                name: AnimalType(rawValue: name) ?? .lion,
                imageURL: $0.src.portrait
            )
        }
        .filter { !$0.imageURL.isEmpty }
    }
}
