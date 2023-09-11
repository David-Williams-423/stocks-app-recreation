//
//  SecondaryDailyInfo.swift
//  Stocks App
//
//  Created by David Williams on 6/11/23.
//

import Foundation

enum SecondaryDailyInfo {
    case percentChange
    case priceChange
    case marketCap
    
    public func get(stock: Stock) -> String {
        
        let previousClose = stock.intraDayQuotes.first!.close
        let currentPrice = stock.intraDayQuotes.last!.close
        let percentChange = ((currentPrice - previousClose) / previousClose) * 100
        
        let priceChange = currentPrice - previousClose
        
        switch self {
        case .percentChange:
            return String(format: "\(percentChange > 0 ? "+" : "")%.2f", percentChange) + "%"
        case .priceChange:
            return FinancialFormatting.formatPrice(priceChange, lowerBound: 0.1, upperBound: 999.99, signed: true)
        case .marketCap:
            return FinancialFormatting.formatMarketCap(stock.fundamental.marketCap)
        }
    }
    
    
}
