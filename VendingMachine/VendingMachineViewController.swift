//
//  ViewController.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/6/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import UIKit

class VendingMachineViewController: UIViewController {

    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var colaButton: UIButton!
    @IBOutlet var chipsButton: UIButton!
    @IBOutlet var candyButton: UIButton!
    @IBOutlet var dispenserButton: UIButton!
    @IBOutlet var changeLabel: UILabel!

    @IBOutlet var pennyButton: UIButton!
    @IBOutlet var nickelButton: UIButton!
    @IBOutlet var dimeButton: UIButton!
    @IBOutlet var quarterButton: UIButton!

    var viewModel: VendingMachineViewModel!

    var _viewModelFactory: (_ coinManager: CoinManager, _ productManager : ProductManager) -> VendingMachineViewModel = {
        return VendingMachineViewModel(coinManager: $0, productManager: $1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = _viewModelFactory(CoinManager(), ProductManager())
        updateDisplayByStatus(status: .noCoin)
    }

    @IBAction func insertPenny() {
        insertCoin(coinType: .penny)
    }

    @IBAction func insertNickel() {
        insertCoin(coinType: .nickel)
    }

    @IBAction func insertDime() {
        insertCoin(coinType: .dime)
    }

    @IBAction func insertQuarter() {
        insertCoin(coinType: .quarter)
    }

    @IBAction func pickupProductAndChange() {
        
    }

    private func insertCoin(coinType: CoinType) {
        viewModel.insertCoin(coin: coinType.coin)
        updateDisplayByStatus(status: .someCoins)
    }

    private func selectProduct(productType: ProductType) {
        let status = viewModel.selectProduct(selectedProductType: productType)
        updateDisplayByStatus(status: status)
    }

    private func updateDisplayByStatus(status: MachineDisplayStatus) {
        switch status {
        case .productSold:
            statusLabel.text = Strings.productSoldText
        case .insufficientFund:
            statusLabel.text = Strings.insufficientCoinText
        default:
            statusLabel.text = viewModel.getCoinAmountText()
        }
    }
}

