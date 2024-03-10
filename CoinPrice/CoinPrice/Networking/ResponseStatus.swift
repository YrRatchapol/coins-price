//
//  ResponseStatus.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 9/3/24.
//

import Foundation

struct ResponseStatus: ResponseProtocol, Equatable {
    var isSuccess: Bool {
        if status == "success" {
            return true
        }
        return false
    }
    var status: String

    init(status: String) {
        self.status = status
    }
}
