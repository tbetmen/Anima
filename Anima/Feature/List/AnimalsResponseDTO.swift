//
//  AnimalsResponseDTO.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

struct AnimalResponseDTO: Decodable {
    let name: String
}

extension Array where Element == AnimalResponseDTO {
    func toEntity(name: String) -> Animal {
        Animal(name: name, types: self.map { $0.name })
    }
}
