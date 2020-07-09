//
//  CoinsManager.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/6/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Foundation

class CoinManager {

    private(set) var insertedCoins: [Coin] = []
    private(set) var returnedCoins: [Coin] = []

    let acceptableCoins: [CoinType] = [.dime, .nickel, .quarter]

    func isValidCoin(insertedCoin: Coin) -> Bool {
        return acceptableCoins.contains(insertedCoin.type)
    }

    func insertCoin(coin: Coin) {
        isValidCoin(insertedCoin: coin) ? insertedCoins.append(coin) : returnedCoins.append(coin)
    }

    func getInsertedAmount() -> Double {
        return insertedCoins.reduce(0) { $0 + $1.value }
    }

    func getReturnedAmount() -> Double {
        return returnedCoins.reduce(0) { $0 + $1.value }
    }

    func hasEnoughFund(product: Product) -> Bool {
        return getInsertedAmount() >= product.price
    }

    func justSoldAnItem() {
        insertedCoins = []
    }

}
