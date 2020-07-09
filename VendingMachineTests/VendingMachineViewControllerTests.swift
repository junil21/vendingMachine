//
//  VendingMachineViewControllerTests.swift
//  VendingMachineTests
//
//  Created by Junil Choi on 7/9/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Quick
import Nimble

@testable import VendingMachine

class VendingMachineViewControllerTests: QuickSpec {
    override func spec() {
        describe("VendingMachineViewController") {
            var subject: VendingMachineViewController!
            var viewModel: MockVendingMachineViewModel!

            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                subject = storyboard.instantiateViewController(withIdentifier: "VendingMachineViewController") as? VendingMachineViewController

                viewModel = .init()
                subject._viewModelFactory = { _, _ in viewModel }

                viewModel.setReturnValue(for: .getCoinAmountText, with: Strings.insufficientCoinText)

            }

            describe("view did load") {
                beforeEach {
                    _ = subject.view
                }

                it("sets its own viewModel") {
                    expect(subject.viewModel).to(be(viewModel))
                }

                it("gets amount text from the view model") {
                    expect(viewModel).to(invoke(.getCoinAmountText))
                }

                it("updates display text") {
                    expect(subject.statusLabel.text).to(equal("INSERT COIN"))
                }

                describe("insert coins") {
                    let expectedAmountText = "100"
                    beforeEach {
                        viewModel.reset()
                        viewModel.setReturnValue(for: .getCoinAmountText, with: expectedAmountText)
                    }

                    context("penny") {
                        beforeEach {
                            subject.pennyButton.sendActions(for: .touchUpInside)
                        }

                        it("calls view model to insert coin") {
                            expect(viewModel).to(invoke(.insertCoin, withParameter: CoinType.penny.coin))
                        }

                        it("gets amount text from the view model") {
                            expect(viewModel).to(invoke(.getCoinAmountText))
                        }

                        it("updates the display text") {
                            expect(subject.statusLabel.text).to(equal(expectedAmountText))
                        }
                    }

                    context("nickel") {
                        beforeEach {
                            subject.nickelButton.sendActions(for: .touchUpInside)
                        }

                        it("calls view model to insert coin") {
                            expect(viewModel).to(invoke(.insertCoin, withParameter: CoinType.nickel.coin))
                        }

                        it("gets amount text from the view model") {
                            expect(viewModel).to(invoke(.getCoinAmountText))
                        }

                        it("updates the display text") {
                            expect(subject.statusLabel.text).to(equal(expectedAmountText))
                        }
                    }

                    context("dime") {
                        beforeEach {
                            subject.dimeButton.sendActions(for: .touchUpInside)
                        }

                        it("calls view model to insert coin") {
                            expect(viewModel).to(invoke(.insertCoin, withParameter: CoinType.dime.coin))
                        }

                        it("gets amount text from the view model") {
                            expect(viewModel).to(invoke(.getCoinAmountText))
                        }

                        it("updates the display text") {
                            expect(subject.statusLabel.text).to(equal(expectedAmountText))
                        }
                    }

                    context("quarter") {
                        beforeEach {
                            subject.quarterButton.sendActions(for: .touchUpInside)
                        }

                        it("calls view model to insert coin") {
                            expect(viewModel).to(invoke(.insertCoin, withParameter: CoinType.quarter.coin))
                        }

                        it("gets amount text from the view model") {
                            expect(viewModel).to(invoke(.getCoinAmountText))
                        }

                        it("updates the display text") {
                            expect(subject.statusLabel.text).to(equal(expectedAmountText))
                        }
                    }
                }

                describe("select product") {

                    describe("product and fund are available") {
                        beforeEach {
                            viewModel.setReturnValue(for: .selectProduct, with: MachineDisplayStatus.productSold)
                        }

                        context("cola") {
                            beforeEach {
                                subject.colaButton.sendActions(for: .touchUpInside)
                            }

                            it("selects the cola") {
                                expect(viewModel).to(invoke(.selectProduct, withParameter: ProductType.cola))
                            }

                            it("sets dispenser button enabled") {
                                expect(subject.dispenserButton.isEnabled).to(beTrue())
                            }
                        }

                        context("chips") {
                            beforeEach {
                                subject.chipsButton.sendActions(for: .touchUpInside)
                            }

                            it("selects the chips") {
                                expect(viewModel).to(invoke(.selectProduct, withParameter: ProductType.chips))
                            }

                            it("sets dispenser button enabled") {
                                expect(subject.dispenserButton.isEnabled).to(beTrue())
                            }
                        }

                        context("candy") {
                            beforeEach {
                                subject.candyButton.sendActions(for: .touchUpInside)
                            }

                            it("selects the candy") {
                                expect(viewModel).to(invoke(.selectProduct, withParameter: ProductType.candy))
                            }

                            it("sets dispenser button enabled") {
                                expect(subject.dispenserButton.isEnabled).to(beTrue())
                            }

                            describe("pick up changes") {
                                beforeEach {
                                    subject.pickupProductAndChange()
                                }

                                it("updates display text") {
                                    expect(subject.statusLabel.text).to(equal("INSERT COIN"))
                                }

                                it("sets dispenser button disable") {
                                    expect(subject.dispenserButton.isEnabled).to(beFalse())
                                }
                            }
                        }
                    }

                    describe("insufficient fund") {
                        let expectedAmountText = "String"
                        let expectedLabelText = "PRICE: $1.00 || \(expectedAmountText)"

                        beforeEach {
                            viewModel.reset()
                            viewModel.setReturnValue(for: .getCoinAmountText, with: expectedAmountText)
                            viewModel.setReturnValue(for: .selectProduct, with: MachineDisplayStatus.insufficientFund)
                            subject.colaButton.sendActions(for: .touchUpInside)
                        }

                        it("dispenser button disabled") {
                            expect(subject.dispenserButton.isEnabled).to(beFalse())
                        }

                        it("gets amount text from the view model") {
                            expect(viewModel).to(invoke(.getCoinAmountText))
                        }

                        it("updates the display text") {
                            expect(subject.statusLabel.text).to(equal(expectedLabelText))
                        }
                    }
                }
            }
        }
    }
}
