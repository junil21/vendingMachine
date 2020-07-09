//
//  MockProductManager.swift
//  VendingMachineTests
//
//  Created by Junil Choi on 7/7/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//


import Foundation
@testable import VendingMachine

class MockProductManager: ProductManager, Mockable {
    typealias MockedMethods = MockedMethod
    var mocker: Mocker<MockedMethod> = Mocker()

    enum MockedMethod: String {
        case isAvailable
        case sellItem
    }

    override func isAvailable(product: Product) -> Bool {
        record(invocation: .isAvailable, with: product)
        return returnValue(for: .isAvailable)!
    }

    override func sellItem(product: Product) {
        record(invocation: .sellItem, with: product)
    }
}
