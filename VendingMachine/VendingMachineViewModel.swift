//
//  VendingMachineViewModel.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/7/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import UIKit

class VendingMachineViewModel: NSObject {

    var insertedAmount: Double = 0

    let acceptCoinManager: AcceptCoinsManager!

    init(acceptCoinsManager: AcceptCoinsManager) {
        self.acceptCoinManager = acceptCoinsManager
    }

    func insertCoin(coin: Coin) {
        if acceptCoinManager.isValidCoin(insertedCoin: coin) {
            insertedAmount += coin.rawValue
        }
    }

    func getCoinAmountText() -> String {
        if insertedAmount == 0 {
            return "INSERT COIN"
        }
        
        return String(format: "%.2f", insertedAmount)
    }
    
}
