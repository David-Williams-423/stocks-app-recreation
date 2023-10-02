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
        let percentChange = ((currentPrice - previousClose) / previousClose)
        
        let priceChange = currentPrice - previousClose
        
        switch self {
        case .percentChange:
            return FinancialFormatting.formatPercent(percentChange)
        case .priceChange:
            return FinancialFormatting.formatPrice(priceChange)
        case .marketCap:
            return FinancialFormatting.formatLargeNumber(stock.fundamental.marketCap)
        }
    }
}
