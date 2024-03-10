//
//  CoinListInteractor.swift
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

protocol CoinListBusinessLogic {
    func doGetCoinList(request: CoinList.GetCoinList.Request)
    func doSelectCoin(request: CoinList.SelectCoin.Request)
    func doSelectCoinTopRank(request: CoinList.SelectCoinTopRank.Request)

    var isLoading: Bool { get set }
    var isLoadFail: Bool { get set }
    var isSearching: Bool { get set }
}

protocol CoinListDataStore {
    var uuid: String? { get set }
}

class CoinListInteractor: CoinListBusinessLogic, CoinListDataStore {
    
    var presenter: CoinListPresentationLogic?
    var worker: CoinListWorker?

    var uuid: String?
    var coinList: [Coin] = []
    var coinTopList: [Coin] = []

    var isLoading: Bool = false
    var isLoadFail: Bool = false
    var isSearching: Bool = false

    let limit = 10
    var offset = 0
    var searhTextOld = ""
    var advOffset = 5
    var advCount = 0

    // MARK: Do something
    func doGetCoinList(request: CoinList.GetCoinList.Request) {
        worker = CoinListWorker()

        // Handle offset
        offset = request.isLoadMore ? coinList.count + (advCount+1) : 0

        // Handle searh condition
        if let searchText = request.searchText {
            if searhTextOld != request.searchText {
                clearData()
            }
            searhTextOld = searchText
        }
        isSearching = !searhTextOld.isEmpty

        let parameter = CoinListRequest.Parameters.init(limit: limit, offset: offset, search: searhTextOld)
        isLoading = true
        isLoadFail = false
        if request.isPullToRefresh {
            isLoading = false
            clearData()
        } else {
            presentCoinList() // show loading
        }

        worker?.loadCoinList(parameters: parameter, completion: { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(_, let response):
                self?.coinList = request.isLoadMore
                ? (self?.coinList ?? []) + (response.data?.coins ?? [])
                : response.data?.coins ?? []
                self?.presentCoinList()
            case .notSuccess, .error:
                self?.isLoadFail = true
                self?.presentCoinList()
            }
        })
    }

    func doSelectCoin(request: CoinList.SelectCoin.Request) {
        guard coinList.count > request.index else {
            return
        }
        uuid = coinList[request.index].uuid
        self.presenter?.presentSelectCoin(response: CoinList.SelectCoin.Response())
    }


    func doSelectCoinTopRank(request: CoinList.SelectCoinTopRank.Request) {
        guard coinTopList.count > request.index else {
            return
        }
        uuid = coinTopList[request.index].uuid
        self.presenter?.presentSelectCoinTopRank(response: CoinList.SelectCoinTopRank.Response())
    }

    func presentCoinList() {
        // Set Coin Top Rank
        if coinTopList.isEmpty && coinList.count >= 3 && !isSearching {
            coinTopList = [coinList[0], coinList[1], coinList[2]]
            coinList.remove(at: 0)
            coinList.remove(at: 0)
            coinList.remove(at: 0)
        }

        // Set Adv
        if coinList.count > advOffset {
            coinList.insert(Coin(), at: advOffset - 1)
            advCount += 1
            advOffset = advOffset * 2
        }

        let response = CoinList.GetCoinList.Response(coins: coinList, coinsTopRank: coinTopList)
        presenter?.presentCoinList(response: response)
    }

    func clearData() {
        coinList = []
        coinTopList = []
        advOffset = 5
        advCount = 0
    }
}