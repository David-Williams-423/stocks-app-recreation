//
//  SecondaryInfo.swift
//  Stocks App
//
//  Created by David Williams on 6/11/23.
//

import Foundation

enum SecondaryInfo {
    case percent(Double)
    case priceChange(Double)
    case marketCap(Int)
    
    func get() -> String {
        switch self {
        case .percent(let num):
            return String(format: "\(num > 0 ? "+" : "")%.2f", num)
        case .priceChange(let num):
            return SecondaryInfo.formatPrice(num, lowerBound: 0.1, upperBound: 999.99, signed: true)
        case .marketCap(let num):
            return SecondaryInfo.formatMarketCap(num)
        }
    }
    
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
    
    public static func formatPrice(_ number: Double, lowerBound: Double, upperBound: Double, signed: Bool) -> String {
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

    
}
