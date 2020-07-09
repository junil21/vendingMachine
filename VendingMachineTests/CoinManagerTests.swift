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
                    expect(subject.isValidCoin(insertedCoin: CoinType.dime.coin)).to(beTrue())
                }

                it("accepts nickel") {
                    expect(subject.isValidCoin(insertedCoin: CoinType.nickel.coin)).to(beTrue())
                }

                it("accepts quarter") {
                    expect(subject.isValidCoin(insertedCoin: CoinType.quarter.coin)).to(beTrue())
                }

                it("doesn't accept penny") {
                    expect(subject.isValidCoin(insertedCoin: CoinType.penny.coin)).to(beFalse())
                }
            }

            describe("insert Coin") {

                let expectedInsertedAmount = 0.50
                let expectedInsertedCoins = [CoinType.dime.coin, CoinType.nickel.coin, CoinType.quarter.coin, CoinType.dime.coin]

                beforeEach {
                    subject.insertCoin(coin: CoinType.dime.coin)
                    subject.insertCoin(coin: CoinType.nickel.coin)
                    subject.insertCoin(coin: CoinType.quarter.coin)
                    subject.insertCoin(coin: CoinType.dime.coin)
                }

                it("updates inserted coin") {
                    expect(subject.insertedCoins).to(equal(expectedInsertedCoins))
                }

                it("updates inserted amount") {
                    expect(subject.getInsertedAmount()).to(equal(expectedInsertedAmount))
                }

                describe("check the fund is enough to buy product") {
                    var actual: Bool!
                    describe("has enough fund") {

                        beforeEach {
                            actual = subject.hasEnoughFund(product: ProductType.chips.product)
                        }

                        it("returns result") {
                            expect(actual).to(beTrue())
                        }
                    }

                    describe("has not enough fund") {

                        beforeEach {
                            actual = subject.hasEnoughFund(product: ProductType.cola.product)
                        }

                        it("returns") {
                            expect(actual).to(beFalse())
                        }
                    }
                }
            }
        }
    }
}
