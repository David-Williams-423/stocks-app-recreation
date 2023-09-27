//
//  FinancialFormatting.swift
//  Stocks App
//
//  Created by David Williams on 6/14/23.
//

import Foundation
import SwiftUI

struct FinancialFormatting {
    public static func formatMarketCap(_ number: Int) -> String {
        let suffixes = ["", "K", "M", "B", "T"]
        var num = Double(number)
        var suffixIndex = 0

        while num >= 1000 && suffixIndex < suffixes.count - 1 {
            num /= 1000
            suffixIndex += 1
        }

        let formattedNumber = String(format: "%.2f", num)
        let suffix = suffixes[suffixIndex]

        return "\(formattedNumber)\(suffix)"

    }
    
    public static func formatPrice(_ number: Double, lowerBound: Double = 0.1, upperBound: Double = 999.99, signed: Bool = true) -> String {
        let absoluteNumber = abs(number) // Get the absolute value

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        if absoluteNumber < lowerBound {
            numberFormatter.minimumFractionDigits = 3
            numberFormatter.maximumFractionDigits = 3
        } else if absoluteNumber <= upperBound {
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
        } else {
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 0
        }

        var formattedString = numberFormatter.string(from: NSNumber(value: absoluteNumber)) ?? ""

        // Add the positive or negative sign
        if signed {
            if number < 0 {
                formattedString = "-" + formattedString
            } else {
                formattedString = "+" + formattedString
            }
        }
        
        return formattedString
    }
    
    public static func formatPercent(_ number: Double, decimalPlaces: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = decimalPlaces
        formatter.maximumFractionDigits = decimalPlaces
        formatter.positivePrefix = formatter.plusSign   // Prefix positive numbers with the plus sign
        
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString
        } else {
            return "\(number)"
        }
    }
    
    public static func getColor(quotes: [Quote]) -> Color {
        guard let last = quotes.last?.close else { return .gray }
        guard let first = quotes.first?.close else { return .gray }
        
        return last - first > 0 ? .green : .red
    }

}
