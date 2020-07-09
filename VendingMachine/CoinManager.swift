//
//  CoinsManager.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/6/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Foundation

class CoinManager {

    private(set) var machineCoins: [Coin] = []
    private(set) var insertedCoins: [Coin] = []
    private(set) var returnedCoins: [Coin] = []

    let acceptableCoins: [CoinType] = [.dime, .nickel, .quarter]

    init() {
        setupMachineFund()
    }

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

    func pickupReturnedCoin() {
        returnedCoins = []
    }

    func setupMachineFund() {
        for _ in 1...10 {
            machineCoins.append(CoinType.nickel.coin)
            machineCoins.append(CoinType.dime.coin)
            machineCoins.append(CoinType.quarter.coin)
        }
    }
}
