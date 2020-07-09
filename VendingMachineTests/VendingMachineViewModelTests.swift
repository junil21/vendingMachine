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
            var productManager: MockProductManager!


            beforeEach {
                coinManager = MockCoinManager()
                productManager = MockProductManager()
                subject = VendingMachineViewModel(coinManager: coinManager, productManager: productManager)
            }

            describe("insert coins") {
                let expectedCoin = CoinType.quarter.coin

                beforeEach {
                    subject.insertCoin(coin: CoinType.quarter.coin)
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

            describe("returns the coins") {
                beforeEach {
                    subject.returnCoins()
                }

                it("calls coin manager to return the coins") {
                    expect(coinManager).to(invoke(.returnCoins))
                }
            }

            describe("get returned coin text") {
                describe("No coin returned") {
                    var returnedAmountString: String!

                    beforeEach {
                        coinManager.setReturnValue(for: .getReturnedAmount, with: Double.zero)
                        returnedAmountString = subject.getReturnedCoinAmountText()
                    }

                    it("returns empty text") {
                        expect(returnedAmountString).to(equal(""))
                    }
                }

                describe("some coin returned") {
                    var returnedAmountString: String!

                    beforeEach {
                        coinManager.setReturnValue(for: .getReturnedAmount, with: Double(0.1))
                        returnedAmountString = subject.getReturnedCoinAmountText()
                    }

                    it("returns the formatted coin amount") {
                        expect(returnedAmountString).to(equal("0.10"))
                    }
                }
            }

            describe("select product") {
                var actualMachineStatus: MachineDisplayStatus!

                describe("sold out") {
                    beforeEach {
                        coinManager.setReturnValue(for: .hasEnoughFund, with: false)
                        productManager.setReturnValue(for: .isAvailable, with: false)
                        actualMachineStatus = subject.selectProduct(selectedProductType: .cola)
                    }

                    it("returns soldOut status") {
                        expect(actualMachineStatus).to(equal(.soldOut))
                    }
                }

                describe("sufficient fund") {
                    beforeEach {
                        coinManager.setReturnValue(for: .hasEnoughFund, with: true)
                        productManager.setReturnValue(for: .isAvailable, with: true)
                        actualMachineStatus = subject.selectProduct(selectedProductType: .cola)
                    }

                    it("returns productSold status") {
                        expect(actualMachineStatus).to(equal(.productSold))
                    }

                    it("call coin manager calculateChanges") {
                        expect(coinManager).to(invoke(.calculateChanges, withParameter: ProductType.cola.product))
                    }
                }

                describe("insufficient fund") {
                    beforeEach {
                        coinManager.setReturnValue(for: .hasEnoughFund, with: false)
                        productManager.setReturnValue(for: .isAvailable, with: true)
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
