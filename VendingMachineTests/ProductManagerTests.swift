//
//  ProductManagerTests.swift
//  VendingMachineTests
//
//  Created by Junil Choi on 7/9/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Quick
import Nimble

@testable import VendingMachine

class ProductManagerTests: QuickSpec {
    override func spec() {
        describe("AcceptCoinManager") {
            var subject: ProductManager!

            beforeEach {
                subject = ProductManager()
            }

            describe("check product is available") {
                var actual: Bool!

                beforeEach {
                    actual = subject.isAvailable(product: ProductType.candy.product)
                }

                it("is available") {
                    expect(actual).to(beTrue())
                }

                describe("sell Items") {
                    let sellingItem = ProductType.candy.product

                    beforeEach {
                        subject.sellItem(product: sellingItem)
                        subject.sellItem(product: sellingItem)
                        actual = subject.isAvailable(product: ProductType.candy.product)
                    }

                    it("is updating the product stock properly"){
                        expect(actual).to(beFalse())
                    }
                }
            }
        }
    }
}
