//
//  UIColor-Extension.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 10/3/24.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        if Scanner(string: hexSanitized).scanHexInt64(&rgb) {
            let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgb & 0x0000FF) / 255.0

            self.init(red: red, green: green, blue: blue, alpha: alpha)
            return
        }

        self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
