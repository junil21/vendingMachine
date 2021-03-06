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

    let acceptableCoins: [CoinType] = [.quarter, .dime, .nickel]

    init() {
        setupDefaultMachineFund()
    }

    func setMachineFund(coins: [Coin]) {
        machineCoins.append(contentsOf: coins)
    }

    func isValidCoin(insertedCoin: Coin) -> Bool {
        return acceptableCoins.contains(insertedCoin.type)
    }

    func isExactChangeOnly() -> Bool {
        return machineCoins.isEmpty
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

    func isTheFundEnough(product: Product) -> Bool {
        return getInsertedAmount() >= product.price
    }

    func calculateChanges(product: Product) {

        let amount = getInsertedAmount()
        var changeAmount = amount - product.price
        machineCoins.append(contentsOf: insertedCoins)
        insertedCoins.removeAll()

        for coinType in acceptableCoins {
            changeAmount = calculateChangesByCoin(changeAmount: changeAmount, coin: coinType.coin)
        }
    }

    private func calculateChangesByCoin(changeAmount: Double, coin: Coin) -> Double {

        let roundedChange = (changeAmount*100).rounded(.toNearestOrAwayFromZero)
        let roundedCoin = (coin.value*100).rounded(.toNearestOrAwayFromZero)
        let coinCount = Int(roundedChange / roundedCoin)

        if coinCount > 0 {
            for _ in 1 ... coinCount {
                returnCoin(coin: coin)
            }
        }

        return changeAmount - (Double(coinCount) * coin.value)
    }

    private func returnCoin(coin: Coin) {
        if let index = machineCoins.firstIndex(of: coin){
            machineCoins.remove(at: index)
        }
        returnedCoins.append(coin)
    }

    func returnCoins() {
        insertedCoins = []
        returnedCoins = []
    }

    func setupDefaultMachineFund() {
        var coins:[Coin] = []
        for _ in 1...3 {
            coins.append(contentsOf: [CoinType.nickel.coin, CoinType.dime.coin, CoinType.quarter.coin])
        }

        setMachineFund(coins: coins)
    }
}
