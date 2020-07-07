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

            beforeEach {
                subject = VendingMachineViewModel(acceptCoinsManager: AcceptCoinsManager())
            }

            describe("insert coins") {

                let expectedInsertedAmount = 0.35
                let expectedInsertedCoins = InsertedCoins(countNickel: 0, countDime: 1, countQuarter: 1)

                beforeEach {
                    subject.insertCoin(coin: .dime)
                    subject.insertCoin(coin: .penny)
                    subject.insertCoin(coin: .quarter)
                }

                it("updates inserted coins") {
                    expect(subject.insertedCoins).to(equal(expectedInsertedCoins))
                }

                it("updates inserted amount") {
                    expect(subject.getInsertedAmount()).to(equal(expectedInsertedAmount))
                }
            }

            describe("get inserted coin text") {
                describe("No coin inserted") {
                    var insertedAmountString: String!

                    beforeEach {
                        insertedAmountString = subject.getCoinAmountText()
                    }

                    it("shows directional text with no coin") {
                        expect(insertedAmountString).to(equal("INSERT COIN"))
                    }
                }

                describe("some coin inserted") {
                    var insertedAmountString: String!

                    beforeEach {
                        subject.insertCoin(coin: .quarter)
                        insertedAmountString = subject.getCoinAmountText()
                    }

                    it("shows the formatted coin amount") {
                        expect(insertedAmountString).to(equal("0.25"))
                    }
                }
            }
        }
    }
}
