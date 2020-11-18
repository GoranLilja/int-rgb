//
//  ColorExtensions.swift
//  IntRGB
//
//  Created by Göran Lilja on 2020-11-18.
//

import SwiftUI

extension Color {
    var components: (red: Double, green: Double, blue: Double, alpha: Double)? {
        var splits = description.split(separator: " ").compactMap { Double($0) }
        guard splits.count == 4 else {
            return nil
        }
        let red = splits.first!
        splits.remove(at: 0)
        let green = splits.first!
        splits.remove(at: 0)
        let blue = splits.first!
        splits.remove(at: 0)
        let alpha = splits.first!
        splits.remove(at: 0)

        return (red: red, green: green, blue: blue, alpha: alpha)
    }
}
