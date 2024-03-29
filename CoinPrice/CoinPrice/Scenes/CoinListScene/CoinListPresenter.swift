//
//  CoinListPresenter.swift
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

protocol CoinListPresentationLogic {
    func presentCoinList(response: CoinList.GetCoinList.Response)
    func presentSelectCoin(response: CoinList.SelectCoin.Response)
    func presentSelectCoinTopRank(response: CoinList.SelectCoinTopRank.Response)
}

class CoinListPresenter: CoinListPresentationLogic {
    weak var viewController: CoinListDisplayLogic?

    // MARK: Do something

    func presentCoinList(response: CoinList.GetCoinList.Response) {
        var coinList: [CoinList.GetCoinList.ViewModel.CoinDisplay] = []
        response.coins.forEach { coin in
            let change = Double(coin.change ?? "0") ?? 0

            coinList.append(CoinList.GetCoinList.ViewModel.CoinDisplay(
                iconImageUrlString: coin.iconURL?.replacingOccurrences(of: ".svg", with: ".png"),
                name: coin.name ?? "-",
                symbol: coin.symbol ?? "-",
                price: "$" + (coin.price?.currency(digits: 5) ?? "-"),
                change: change > 0 ? .up : .down,
                changeRate: (coin.change?.replacingOccurrences(of: "-", with: "").currency() ?? "-"),
                isForAdv: coin.isForAdv ?? false)
            )
        }

        var coinTopRankList: [CoinList.GetCoinList.ViewModel.CoinDisplay] = []
        response.coinsTopRank.forEach { coin in
            let change = Double(coin.change ?? "0") ?? 0

            coinTopRankList.append(CoinList.GetCoinList.ViewModel.CoinDisplay(
                iconImageUrlString: coin.iconURL?.replacingOccurrences(of: ".svg", with: ".png"),
                name: coin.name ?? "-",
                symbol: coin.symbol ?? "-",
                price: "$" + (coin.price?.currency(digits: 5) ?? "-"),
                change: change > 0 ? .up : .down,
                changeRate: (coin.change?.replacingOccurrences(of: "-", with: "").currency() ?? "-"),
                isForAdv: coin.isForAdv ?? false)
            )
        }

        let viewModel = CoinList.GetCoinList.ViewModel(displayedCoinList: coinList,
                                                       displayedCoinTopRankList: coinTopRankList)
        viewController?.displayCoinList(viewModel: viewModel)
    }


    func presentSelectCoin(response: CoinList.SelectCoin.Response) {
        viewController?.displaySelectCoin(viewModel: CoinList.SelectCoin.ViewModel())
    }


    func presentSelectCoinTopRank(response: CoinList.SelectCoinTopRank.Response) {
        viewController?.displaySelectCoinTopRank(viewModel: CoinList.SelectCoinTopRank.ViewModel())
    }
}
