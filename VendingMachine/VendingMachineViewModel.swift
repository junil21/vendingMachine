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

    func returnCoins() {
        coinManager.returnCoins()
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
        let product = selectedProductType.product

        guard productManager.isAvailable(product: product) else {
            return .soldOut
        }

        guard coinManager.isTheFundEnough(product: product) else {
            return .insufficientFund
        }

        coinManager.calculateChanges(product: product)
        return .productSold
    }
}

enum MachineDisplayStatus: String {
    case someCoins
    case productSold
    case insufficientFund
    case soldOut
    case noCoin
}

