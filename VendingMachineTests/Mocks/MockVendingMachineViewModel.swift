//
//  MockVendingMachineViewModel.swift
//  VendingMachineTests
//
//  Created by Junil Choi on 7/9/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Foundation
@testable import VendingMachine

class MockVendingMachineViewModel: VendingMachineViewModel, Mockable {
    typealias MockedMethods = MockedMethod
    var mocker: Mocker<MockedMethod> = Mocker()

    enum MockedMethod: String {
        case insertCoin
        case getCoinAmountText
        case getReturnedCoinAmountText
        case selectProduct
        case returnCoins
        case isExactChangeOnly
    }

    init() {
        super.init(coinManager: MockCoinManager(), productManager: MockProductManager())
    }

    override func insertCoin(coin: Coin) {
        record(invocation: .insertCoin, with: coin)
    }

    override func getCoinAmountText() -> String {
        record(invocation: .getCoinAmountText)
        return returnValue(for: .getCoinAmountText)!
    }

    override func getReturnedCoinAmountText() -> String {
        record(invocation: .getReturnedCoinAmountText)
        return returnValue(for: .getReturnedCoinAmountText)!
    }

    override func selectProduct(selectedProductType: ProductType) -> MachineDisplayStatus {
        record(invocation: .selectProduct, with: selectedProductType)
        return returnValue(for: .selectProduct)!
    }

    override func returnCoins() {
        record(invocation: .returnCoins)
    }

    override func isExactChangeOnly() -> Bool {
        record(invocation: .isExactChangeOnly)
        return returnValue(for: .isExactChangeOnly)!
    }
}
