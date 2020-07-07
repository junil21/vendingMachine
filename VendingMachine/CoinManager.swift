//
//  CoinsManager.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/6/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Foundation

class CoinManager {

    var insertedCoins: InsertedCoins = .noCoin

    let acceptableCoins: [Coin] = [.dime, .nickel, .quarter]

    func isValidCoin(insertedCoin: Coin) -> Bool {
        return acceptableCoins.contains(insertedCoin)
    }

    func insertCoin(coin: Coin) {

        guard isValidCoin(insertedCoin: coin) else {
            return
        }

        var nickels = insertedCoins.countNickel
        var dimes = insertedCoins.countDime
        var quarters = insertedCoins.countQuarter

        switch coin {
        case .nickel:
            nickels += 1
        case .dime:
            dimes += 1
        case .quarter:
            quarters += 1
        default:
            break
        }

        insertedCoins = InsertedCoins(countNickel: nickels, countDime: dimes, countQuarter: quarters)
    }

    func getInsertedCoin() -> InsertedCoins {
        return insertedCoins
    }

    func getInsertedAmount() -> Double {
        var amount = Double(insertedCoins.countDime) * Coin.dime.rawValue
        amount += Double(insertedCoins.countNickel) * Coin.nickel.rawValue
        amount += Double(insertedCoins.countQuarter) * Coin.quarter.rawValue

        return amount
    }

    func hasEnoughFund(product: Product) -> Bool {
        return getInsertedAmount() >= product.price
    }

    func justSoldAnItem() {
        insertedCoins = .noCoin
    }

}

enum Coin: Double {
    case penny = 0.01
    case nickel = 0.05
    case dime = 0.10
    case quarter = 0.25
}
