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
    
    init(stock: Stock) {
        self.stock = stock
        
        let previousClose = stock.quotes.first!.close
        let currentPrice = stock.quotes.last!.close
        let percentChange = (currentPrice - previousClose) / previousClose
        
        secondaryInfo = .percentChange(percentChange)
    }
    
 
}
