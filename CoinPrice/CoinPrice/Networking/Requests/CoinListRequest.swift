//
//  CoinListRequest.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 8/3/24.
//

import Foundation

class CoinListRequest: RequestProtocol {
    var apiPath: String {
        return "coins?limit=\(getParameters.limit)&offset=\(getParameters.offset)&search=\(getParameters.search)"
    }
    let apiVersion: UInt = 2
    let method = RequestMethod.get
    var result: Result<CoinListResponse>?
    var parameters = NoParameters()
    private var getParameters: Parameters

    init(parameters: Parameters) {
        self.getParameters = parameters
    }

    struct Parameters: Encodable {
        var limit: Int
        var offset: Int
        var search: String
    }
}
