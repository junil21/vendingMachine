//
//  Coin.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/8/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import UIKit

struct Coin: Equatable {
    let value: Double
    let weight: Double
    let type: CoinType

    init(value: Double, weight: Double, type: CoinType) {
        self.value = value
        self.weight = weight
        self.type = type
    }
}

enum CoinType {
    case penny
    case nickel
    case dime
    case quarter

    var coin: Coin {
        switch self {
        case .penny: return Coin(value: 0.01, weight: 2.5, type: self)
        case .nickel: return Coin(value: 0.05, weight: 5, type: self)
        case .dime: return Coin(value: 0.10, weight: 2.268, type: self)
        case .quarter: return Coin(value: 0.25, weight: 5.67, type: self)
        }
    }
}
