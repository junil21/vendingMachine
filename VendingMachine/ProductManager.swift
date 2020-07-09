//
//  ProductManager.swift
//  VendingMachine
//
//  Created by Junil Choi on 7/7/20.
//  Copyright © 2020 Junil Choi. All rights reserved.
//

import UIKit

class ProductManager {

    init() {
        restock()
    }

    private(set) var productStock: [Product] = []

    func isAvailable(product: Product) -> Bool {
        return productStock.contains(product)
    }

    func sellItem(product: Product) {
        if let index = productStock.firstIndex(of: product){
            productStock.remove(at: index)
        }
    }

    func restock() {
        for _ in 1...2 {
            productStock.append(ProductType.cola.product)
            productStock.append(ProductType.chips.product)
            productStock.append(ProductType.candy.product)
        }
    }
}
