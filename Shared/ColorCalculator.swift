//
//  UIColorExtensions.swift
//  IntRGB
//
//  Created by Göran Lilja on 2020-11-18.
//

import Foundation

struct RGBA {
    let r: Int32
    let g: Int32
    let b: Int32
    let a: Int32
}

enum ColorCalculator {
    static func RBGAFromInteger(rgbValue: Int32) -> RGBA {
        let blue: Int32 = rgbValue & 0xFF
        let green: Int32 = (rgbValue >> 8) & 0xFF
        let red: Int32 = (rgbValue >> 16) & 0xFF
        let alpha: Int32 = (rgbValue >> 24) & 0xFF

        return RGBA(r: red, g: green, b: blue, a: alpha)
    }

    static func colorIntFromRBG(r: Int32, g: Int32, b: Int32, a: Int32) -> Int32 {
        var rgbaValue: Int32 = a << 24
        rgbaValue += r << 16
        rgbaValue += g << 8
        rgbaValue += b

        return rgbaValue
    }
}
