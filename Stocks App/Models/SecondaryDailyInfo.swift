//
//  SecondaryDailyInfo.swift
//  Stocks App
//
//  Created by David Williams on 6/11/23.
//

import Foundation

enum SecondaryDailyInfo {
    case percentChange(Double)
    case priceChange(Double)
    case marketCap(Int)
    
    public func get() -> String {
        switch self {
        case .percentChange(let num):
            return String(format: "\(num > 0 ? "+" : "")%.2f", num) + "%"
        case .priceChange(let num):
            return FinancialFormatting.formatPrice(num, lowerBound: 0.1, upperBound: 999.99, signed: true)
        case .marketCap(let num):
            return FinancialFormatting.formatMarketCap(num)
        }
    }
    
    
    
}
