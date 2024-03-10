//
//  CoinDetailResponse.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 10/3/24.
//

import Foundation

// MARK: - CoinDetailResponse
struct CoinDetailResponse: ResponseProtocol {
    var status: String?
    var data: CoinDetailData?
}

// MARK: - CoinDetailData
struct CoinDetailData: Codable {
    var coin: CoinInfo?
}

// MARK: - Coin
struct CoinInfo: Codable {
    var uuid: String?
    var symbol: String?
    var name: String?
    var description: String?
    var color: String?
    var iconURL: String?
    var websiteURL: String?
    var numberOfMarkets: Int?
    var numberOfExchanges: Int?
    var the24HVolume: String?
    var marketCap: String?
    var fullyDilutedMarketCap: String?
    var price: String?
    var btcPrice: String?
    var priceAt: Int?
    var change: String?
    var rank: Int?
    var sparkline: [String?]?
    var coinrankingURL: String?
    var tier: Int?
    var lowVolume: Bool?
    var listedAt: Int?
    var hasContent: Bool?
    var tags: [String]?

    enum CodingKeys: String, CodingKey {
            case uuid = "uuid"
            case symbol = "symbol"
            case name = "name"
            case description = "description"
            case color = "color"
            case iconURL = "iconUrl"
            case websiteURL = "websiteUrl"
            case numberOfMarkets = "numberOfMarkets"
            case numberOfExchanges = "numberOfExchanges"
            case the24HVolume = "24hVolume"
            case marketCap = "marketCap"
            case fullyDilutedMarketCap = "fullyDilutedMarketCap"
            case price = "price"
            case btcPrice = "btcPrice"
            case priceAt = "priceAt"
            case change = "change"
            case rank = "rank"
            case sparkline = "sparkline"
            case coinrankingURL = "coinrankingUrl"
            case tier = "tier"
            case lowVolume = "lowVolume"
            case listedAt = "listedAt"
            case hasContent = "hasContent"
            case tags = "tags"
        }
}
