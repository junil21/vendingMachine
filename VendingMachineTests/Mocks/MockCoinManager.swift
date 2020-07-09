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
        case justSoldAnItem
        case getReturnedAmount
    }

    override func insertCoin(coin: Coin) {
        record(invocation: .insertCoin, with: coin)
    }

    override func getInsertedAmount() -> Double {
        record(invocation: .getInsertedAmount)
        return returnValue(for: .getInsertedAmount)!
    }

    override func hasEnoughFund(product: Product) -> Bool {
        record(invocation: .hasEnoughFund)
        return returnValue(for: .hasEnoughFund)!
    }

    override func justSoldAnItem() {
        record(invocation: .justSoldAnItem)
    }

    override func getReturnedAmount() -> Double {
        record(invocation: .getReturnedAmount)
        return returnValue(for: .getReturnedAmount)!
    }
}
