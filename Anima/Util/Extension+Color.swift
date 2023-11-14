//
//  Extension+Color.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import UIKit
import SwiftUI

extension Color {
    
    init(hex: UInt32, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    public static let jade = Color(hex: 0x00BF63)
    public static let pweter = Color(hex: 0x9EB0A2)
    public static let cerulean = Color(hex: 0x00BDFF)
    public static let gullGray = Color(hex: 0x99AEBA)
}
