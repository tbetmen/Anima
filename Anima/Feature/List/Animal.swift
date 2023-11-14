//
//  Animal.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

struct Animal: Identifiable {
    let id = UUID()
    var name: String = ""
    var types = [String]()
    var isExpanded = false
    
    var nameFormatted: String {
        name.capitalized
    }
    var typesFormatted: String {
        types.joined(separator: ", ")
    }
}
