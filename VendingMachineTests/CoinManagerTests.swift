//
//  CoinManagerTest.swift
//  VendingMachineTests
//
//  Created by Junil Choi on 7/7/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Quick
import Nimble

@testable import VendingMachine

class CoinManagerTests: QuickSpec {
    override func spec() {
        describe("AcceptCoinManager") {
            var subject: CoinManager!

            beforeEach {
                subject = CoinManager()
            }

            describe("validate acceptable coins") {

                it("accepts dime") {
                    expect(subject.isValidCoin(insertedCoin: .dime)).to(beTrue())
                }

                it("accepts nickel") {
                    expect(subject.isValidCoin(insertedCoin: .nickel)).to(beTrue())
                }

                it("accepts quarter") {
                    expect(subject.isValidCoin(insertedCoin: .quarter)).to(beTrue())
                }

                it("doesn't accept penny") {
                    expect(subject.isValidCoin(insertedCoin: .penny)).to(beFalse())
                }
            }

            describe("insert Coin") {

                let expectedInsertedAmount = 0.40
                let expectedInsertedCoin = InsertedCoins(countNickel: 1, countDime: 1, countQuarter: 1)

                beforeEach {
                    subject.insertCoin(coin: .nickel)
                    subject.insertCoin(coin: .dime)
                    subject.insertCoin(coin: .quarter)
                }

                it("updates inserted coin") {
                    expect(subject.getInsertedCoin()).to(equal(expectedInsertedCoin))
                }

                it("updates inserted amount") {
                    expect(subject.getInsertedAmount()).to(equal(expectedInsertedAmount))
                }
            }
        }
    }
}
