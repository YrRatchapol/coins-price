//
//  Data-Extension.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 8/3/24.
//

import Foundation

extension Data {
    func toUTF8String() -> String {
        if let returnString = String(data: self, encoding: String.Encoding.utf8) {
            return returnString
        }
        return ""
    }
}
