//
//  AcceptCoinsManager.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/6/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Foundation

class AcceptCoinsManager {

    let acceptableCoins: [Coin] = [.dime, .nickel, .quarter]

    func isValidCoin(insertedCoin: Coin) -> Bool {
        return acceptableCoins.contains(insertedCoin)
    }

}

enum Coin: Float {
    case penny = 0.01
    case nickel = 0.05
    case dime = 0.10
    case quarter = 0.25
}
