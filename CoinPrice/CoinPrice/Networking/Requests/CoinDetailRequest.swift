//
//  CoinDetailRequest.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 10/3/24.
//

import Foundation

class CoinDetailRequest: RequestProtocol {
    var apiPath: String {
        return "coin/\(getParameters.uuid)"
    }
    let apiVersion: UInt = 2
    let method = RequestMethod.get
    var result: Result<CoinDetailResponse>?
    var parameters = NoParameters()
    private var getParameters: Parameters

    init(parameters: Parameters) {
        self.getParameters = parameters
    }

    struct Parameters: Encodable {
        var uuid: String
    }
}
