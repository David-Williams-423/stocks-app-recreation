//
//  Search.swift
//  Stocks
//
//  Created by David Williams on 10/2/23.
//

import Foundation

// MARK: - Welcome
struct SearchResults: Codable {
    let bestMatches: [BestMatch]
}

// MARK: - BestMatch
struct BestMatch: Codable {
    let symbol, name: String
    let type: String
    let region: String
    let marketOpen: String
    let marketClose, timezone, currency, matchScore: String

    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case region = "4. region"
        case marketOpen = "5. marketOpen"
        case marketClose = "6. marketClose"
        case timezone = "7. timezone"
        case currency = "8. currency"
        case matchScore = "9. matchScore"
    }
}
