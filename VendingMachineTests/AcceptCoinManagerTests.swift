//
//  AcceptCoinManager.swift
//  VendingMachineTests
//
//  Created by Junil Choi on 7/7/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Quick
import Nimble

@testable import VendingMachine

class AcceptCoinManagerTests: QuickSpec {
    override func spec() {
        describe("AcceptCoinManager") {
            var subject: AcceptCoinsManager!

            beforeEach {
                subject = AcceptCoinsManager()
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
        }
    }
}
