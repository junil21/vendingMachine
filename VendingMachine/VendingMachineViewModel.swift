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
    let productManager: ProductManager!

    init(coinManager: CoinManager, productManager: ProductManager) {
        self.coinManager = coinManager
        self.productManager = productManager
    }

    func insertCoin(coin: Coin) {
        coinManager.insertCoin(coin: coin)
    }

    func getCoinAmountText() -> String {
        let amount = coinManager.getInsertedAmount()
        return amount != 0 ? String(format: "%.2f", amount) : Strings.insufficientCoinText
    }

    func getReturnedCoinAmountText() -> String {
        let amount = coinManager.getReturnedAmount()
        return amount != 0 ? String(format: "%.2f", amount) : ""
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
    case insufficientFund
    case noCoin
}

