//
//  String-Extension.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 10/3/24.
//

import Foundation

extension String {
    func currency(digits: Int? = nil) -> String {
        if let number = Decimal(string: self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = ""
            if let digits = digits {
                formatter.maximumFractionDigits = digits
                formatter.minimumFractionDigits = digits
            }
            if let formattedString = formatter.string(from: number as NSDecimalNumber) {
                return formattedString
            } else {
                return self //Error formatting number
            }
        } else {
            return self //Invalid number format
        }
    }
}
