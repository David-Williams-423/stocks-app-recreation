//
//  TimeScales.swift
//  Stocks
//
//  Created by David Williams on 9/27/23.
//

import Foundation

enum TimeScale {
    case oneDay, oneWeek, oneMonth, threeMonths, sixMonths, yearToDate, oneYear, twoYears, fiveYears, tenYears, all

    public func textRepresentation() -> String {
        switch self {
        case .oneDay:
            "1D"
        case .oneWeek:
            "1W"
        case .oneMonth:
            "1M"
        case .threeMonths:
            "3M"
        case .sixMonths:
            "6M"
        case .yearToDate:
            "YTD"
        case .oneYear:
            "1Y"
        case .twoYears:
            "2Y"
        case .fiveYears:
            "5Y"
        case .tenYears:
            "10Y"
        case .all:
            "ALL"
        }
    }

    static var allCases: [TimeScale] {
        return [.oneDay, .oneWeek, .oneMonth, .threeMonths, .sixMonths, .yearToDate, .oneYear, .twoYears, .fiveYears, .tenYears, .all]
    }

    static var allTexts: [String] {
        return allCases.map { $0.textRepresentation() }
    }
}
