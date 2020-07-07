//
//  VendingMachineViewModelTests.swift
//  VendingMachineTests
//
//  Created by Junil Choi on 7/7/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Quick
import Nimble

@testable import VendingMachine

class VendingMachineViewModelTests: QuickSpec {
    override func spec() {
        describe("VendingMachineViewModel") {
            var subject: VendingMachineViewModel!
            var coinManager: MockCoinManager!


            beforeEach {
                coinManager = MockCoinManager()
                subject = VendingMachineViewModel(acceptCoinsManager: coinManager)
            }

            describe("insert coins") {
                let expectedCoin = Coin.quarter

                beforeEach {
                    coinManager.insertCoin(coin: .quarter)
                }

                it("updates inserted coins") {
                    expect(coinManager).to(invoke(.insertCoin, withParameter: expectedCoin))
                }
            }

            describe("get inserted coin text") {
                describe("No coin inserted") {
                    var insertedAmountString: String!

                    beforeEach {
                        coinManager.setReturnValue(for: .getInsertedAmount, with: Double.zero)
                        insertedAmountString = subject.getCoinAmountText()
                    }

                    it("shows directional text with no coin") {
                        expect(insertedAmountString).to(equal(Strings.insufficientCoinText))
                    }
                }

                describe("some coin inserted") {
                    var insertedAmountString: String!

                    beforeEach {
                        coinManager.setReturnValue(for: .getInsertedAmount, with: Double(0.25))
                        insertedAmountString = subject.getCoinAmountText()
                    }

                    it("shows the formatted coin amount") {
                        expect(insertedAmountString).to(equal("0.25"))
                    }
                }
            }

            describe("select product") {
                var actualMachineStatus: MachineDisplayStatus!

                describe("sufficient fund") {
                    beforeEach {
                        coinManager.setReturnValue(for: .hasEnoughFund, with: true)
                        actualMachineStatus = subject.selectProduct(selectedProductType: .cola)
                    }

                    it("returns productSold status") {
                        expect(actualMachineStatus).to(equal(.productSold))
                    }
                }

                describe("sufficient fund") {
                    beforeEach {
                        coinManager.setReturnValue(for: .hasEnoughFund, with: false)
                        actualMachineStatus = subject.selectProduct(selectedProductType: .cola)
                    }

                    it("returns insufficientFund status") {
                        expect(actualMachineStatus).to(equal(.insufficientFund))
                    }
                }
            }
        }
    }
}
