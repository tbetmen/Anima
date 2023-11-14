//
//  Extension+Font.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import SwiftUI

extension Font {
    public static func textLight(size: CGFloat) -> Font {
        Font.custom("Avenir Light", size: size)
    }
    public static func textBook(size: CGFloat) -> Font {
        Font.custom("Avenir Book", size: size)
    }
    public static func textMedium(size: CGFloat) -> Font {
        Font.custom("Avenir Medium", size: size)
    }
    public static func textHeavy(size: CGFloat) -> Font {
        Font.custom("Avenir Heavy", size: size)
    }
    public static func textBlack(size: CGFloat) -> Font {
        Font.custom("Avenir Black", size: size)
    }
}
