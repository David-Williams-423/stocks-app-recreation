//
//  CellViewViewModel.swift
//  Stocks App
//
//  Created by David Williams on 6/12/23.
//

import Foundation

class CellViewModel: ObservableObject {
    @Published var stock: Stock
    @Published var secondaryInfo: SecondaryDailyInfo = .percentChange(0.0)
    
    var price: String {
        FinancialFormatting.formatPrice(stock.price, lowerBound: 5.0, upperBound: 99999.99, signed: false)
    }
    
    
    
    init(stock: Stock) {
        self.stock = stock
        
        let previousClose = stock.intraDayQuotes.first!.close
        let currentPrice = stock.intraDayQuotes.last!.close
        let percentChange = ((currentPrice - previousClose) / previousClose) * 100
        
        secondaryInfo = .percentChange(percentChange)
    }
    
 
}
