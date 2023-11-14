//
//  AnimalPhoto.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

struct AnimalPhoto: Identifiable {
    let id: Int
    let name: AnimalType
    let imageURL: String
    var isLiked = false
}

extension AnimalPhoto {
    func update(isLiked: Bool) -> AnimalPhoto {
        AnimalPhoto(id: id, name: name, imageURL: imageURL, isLiked: isLiked)
    }
}
