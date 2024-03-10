//
//  CoinListResponse.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 8/3/24.
//

import Foundation

// MARK: - CoinListResponse
struct CoinListResponse: ResponseProtocol {
    var status: String?
    var data: CoinListData?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

// MARK: - DataClass
struct CoinListData: Codable {
    var stats: Stats?
    var coins: [Coin]?

    enum CodingKeys: String, CodingKey {
        case stats = "stats"
        case coins = "coins"
    }
}

// MARK: - Coin
struct Coin: Codable {
    var uuid: String?
    var symbol: String?
    var name: String?
    var color: String?
    var iconURL: String?
    var marketCap: String?
    var price: String?
    var listedAt: Int?
    var tier: Int?
    var change: String?
    var rank: Int?
    var sparkline: [String?]?
    var lowVolume: Bool?
    var coinrankingURL: String?
    var the24HVolume: String?
    var btcPrice: String?
    var contractAddresses: [String]?

    var isForAdv: Bool?

    init() {
        isForAdv = true
    }

    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case symbol = "symbol"
        case name = "name"
        case color = "color"
        case iconURL = "iconUrl"
        case marketCap = "marketCap"
        case price = "price"
        case listedAt = "listedAt"
        case tier = "tier"
        case change = "change"
        case rank = "rank"
        case sparkline = "sparkline"
        case lowVolume = "lowVolume"
        case coinrankingURL = "coinrankingUrl"
        case the24HVolume = "24hVolume"
        case btcPrice = "btcPrice"
        case contractAddresses = "contractAddresses"
    }
}

// MARK: - Stats
struct Stats: Codable {
    var total: Int?
    var totalCoins: Int?
    var totalMarkets: Int?
    var totalExchanges: Int?
    var totalMarketCap: String?
    var total24HVolume: String?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalCoins = "totalCoins"
        case totalMarkets = "totalMarkets"
        case totalExchanges = "totalExchanges"
        case totalMarketCap = "totalMarketCap"
        case total24HVolume = "total24hVolume"
    }
}
