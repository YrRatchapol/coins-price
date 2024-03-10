//
//  CoinListModels.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 9/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum CoinList {
    // MARK: Use cases

    enum GetCoinList {
        struct Request {
            var searchText: String? = nil
            var isPullToRefresh: Bool = false
            var isLoadMore: Bool = false
        }
        struct Response {
            let coins: [Coin]
            let coinsTopRank: [Coin]
        }
        struct ViewModel {
            struct CoinDisplay: Equatable {
                let iconImageUrlString: String?
                let name: String
                let symbol: String
                let price: String
                let change: Change
                let changeRate: String
                let isForAdv: Bool
            }
            enum Change {
                case up
                case down
            }
            let displayedCoinList: [CoinDisplay]
            let displayedCoinTopRankList: [CoinDisplay]
        }
    }

    enum SelectCoin {
        struct Request {
            let index: Int
        }
        struct Response {
        }
        struct ViewModel {
        }
    }

    enum SelectCoinTopRank {
        struct Request {
            let index: Int
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
}
