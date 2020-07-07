//
//  VendingMachineViewModel.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/7/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import UIKit

class VendingMachineViewModel: NSObject {

    var insertedCoins: InsertedCoins = InsertedCoins.noCoin
    private var insertedAmount: Double = 0

    let acceptCoinManager: AcceptCoinsManager!

    init(acceptCoinsManager: AcceptCoinsManager) {
        self.acceptCoinManager = acceptCoinsManager
    }

    func insertCoin(coin: Coin) {

        guard acceptCoinManager.isValidCoin(insertedCoin: coin) else {
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

    func getInsertedAmount() -> Double {
        var amount = Double(insertedCoins.countDime) * Coin.dime.rawValue
        amount += Double(insertedCoins.countNickel) * Coin.nickel.rawValue
        amount += Double(insertedCoins.countQuarter) * Coin.quarter.rawValue

        return amount
    }

    func getCoinAmountText() -> String {
        let amount = getInsertedAmount()
        if amount == 0 {
            return "INSERT COIN"
        }
        
        return String(format: "%.2f", amount)
    }
    
}

struct InsertedCoins: Equatable {
    let countNickel: Int
    let countDime: Int
    let countQuarter: Int

    static let noCoin = InsertedCoins(countNickel: 0, countDime: 0, countQuarter: 0)
}
