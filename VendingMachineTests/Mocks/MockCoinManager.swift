//
//  MockCoinManager.swift
//  VendingMachineTests
//
//  Created by Junil Choi on 7/7/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Foundation
@testable import VendingMachine

class MockCoinManager: CoinManager, Mockable {
    typealias MockedMethods = MockedMethod
    var mocker: Mocker<MockedMethod> = Mocker()

    enum MockedMethod: String {
        case insertCoin
        case getInsertedAmount
        case getInsertedCoin
        case hasEnoughFund
        case getReturnedAmount
        case calculateChanges
        case returnCoins
        case isExactChangeOnly
        case setMachineFund
    }

    override func insertCoin(coin: Coin) {
        record(invocation: .insertCoin, with: coin)
    }

    override func getInsertedAmount() -> Double {
        record(invocation: .getInsertedAmount)
        return returnValue(for: .getInsertedAmount)!
    }

    override func isTheFundEnough(product: Product) -> Bool {
        record(invocation: .hasEnoughFund)
        return returnValue(for: .hasEnoughFund)!
    }

    override func calculateChanges(product: Product) {
        record(invocation: .calculateChanges, with: product)
    }

    override func getReturnedAmount() -> Double {
        record(invocation: .getReturnedAmount)
        return returnValue(for: .getReturnedAmount)!
    }

    override func returnCoins() {
        record(invocation: .returnCoins)
    }

    override func isExactChangeOnly() -> Bool {
        record(invocation: .isExactChangeOnly)
        return returnValue(for: .isExactChangeOnly)!
    }

    override func setMachineFund(coins: [Coin]) {
        record(invocation: .isExactChangeOnly, with: coins)
    }
}
