//
//  CellViewViewModel.swift
//  Stocks App
//
//  Created by David Williams on 6/12/23.
//

import Foundation

class CellViewModel: ObservableObject {
    @Published var stock: Stock
    
    var price: String {
        FinancialFormatting.formatPrice(self.stock.price, lowerBound: 5.0, upperBound: 99999.99, signed: false)
    }
    
    init(stock: Stock) {
        self.stock = stock
    }
    
    
}
