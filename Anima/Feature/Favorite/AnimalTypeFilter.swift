//
//  AnimalTypeFilter.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

struct AnimalTypeFilter: Identifiable {
    var id: Int
    var name: AnimalType
    var isChecked: Bool = false
}

extension AnimalTypeFilter {
    static let datas = [
        AnimalTypeFilter(id: 1, name: .elephant),
        AnimalTypeFilter(id: 2, name: .lion),
        AnimalTypeFilter(id: 3, name: .fox),
        AnimalTypeFilter(id: 4, name: .dog),
        AnimalTypeFilter(id: 5, name: .shark),
        AnimalTypeFilter(id: 6, name: .turtle),
        AnimalTypeFilter(id: 7, name: .whale),
        AnimalTypeFilter(id: 8, name: .penguin),
    ]
}

extension Array where Element == AnimalTypeFilter {
    func animalTypes() -> [AnimalType] {
        self.filter { $0.isChecked }.map { $0.name }
    }
}
