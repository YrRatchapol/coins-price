//
//  Result.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 8/3/24.
//

import Foundation

enum Result<Response> {
    case success(ResponseStatus, Response)
    case notSuccess(ResponseStatus, Response?)
    case error(Error)
}
