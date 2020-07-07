//
//  Product.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/7/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import Foundation

struct Product: Equatable {
    let name: String
    let price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}

enum ProductType {
    case cola
    case chips
    case candy

    var product: Product {
        switch self {
        case .cola: return Product(name: "Cola", price: 1.00)
        case .chips: return Product(name: "Chips", price: 0.50)
        case .candy: return Product(name: "Candy", price: 0.65)
        }
    }
}
