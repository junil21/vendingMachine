//
//  VendingMachineViewModel.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/7/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import UIKit

class VendingMachineViewModel: NSObject {
    private var insertedAmount: Double = 0

    let coinManager: CoinManager!

    init(acceptCoinsManager: CoinManager) {
        self.coinManager = acceptCoinsManager
    }

    func insertCoin(coin: Coin) {
        coinManager.insertCoin(coin: coin)
    }

    func getCoinAmountText() -> String {
        let amount = coinManager.getInsertedAmount()
        if amount == 0 {
            return Strings.insufficientCoinText
        }
        
        return String(format: "%.2f", amount)
    }

    func selectProduct(selectedProductType: ProductType) -> MachineDisplayStatus {
        if coinManager.hasEnoughFund(product: selectedProductType.product) {
            coinManager.justSoldAnItem()
            return .productSold
        }
        return .insufficientFund
    }
    
}

enum MachineDisplayStatus: String {
    case someCoins
    case productSold
    case insufficientFund = "INSERT COIN"
}

struct InsertedCoins: Equatable {
    let countNickel: Int
    let countDime: Int
    let countQuarter: Int

    static let noCoin = InsertedCoins(countNickel: 0, countDime: 0, countQuarter: 0)
}
