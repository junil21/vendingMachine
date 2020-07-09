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

    var productStock: [Product] = []
    var dispensedProduct: Product?

    func isAvailable(product: Product) -> Bool {
        return productStock.contains(product)
    }

    func sellItem(product: Product) {
        if let index = productStock.firstIndex(of: product){
            productStock.remove(at: index)
        }
    }


    func restock() {
        productStock = [
            ProductType.candy.product,
            ProductType.cola.product,
            ProductType.chips.product,
            ProductType.cola.product,
            ProductType.chips.product,
            ProductType.candy.product
        ]
    }
}
