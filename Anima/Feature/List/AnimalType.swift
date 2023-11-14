//
//  AnimalType.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

enum AnimalType: String, CaseIterable {
    case elephant
    case lion
    case fox
    case dog
    case shark
    case turtle
    case whale
    case penguin
    
    var formatted: String {
        self.rawValue.capitalized
    }
}
