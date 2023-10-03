//
//  IntradayQuotes.swift
//  Stocks
//
//  Created by David Williams on 10/2/23.
//

import Foundation

struct IntradayQuotes: Codable {
    let metaData: MetaData
    var timeSeries: TimeSeries

    enum TimeSeries {
        case intraday([String: IntradayQuote])
        case daily([String: DailyQuote])
        case weekly([String: DailyQuote])
        case monthly([String: DailyQuote])
    }

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
    }

    private var timeSeriesKeys: [String: TimeSeries] {
        return [
            "Time Series (1min)": .intraday([:]),
            "Time Series (5min)": .intraday([:]),
            "Time Series (15min)": .intraday([:]),
            "Time Series (30min)": .intraday([:]),
            "Time Series (60min)": .intraday([:]),
            "Time Series (Daily)": .daily([:]),
            "Weekly Adjusted Time Series": .weekly([:]),
            "Monthly Adjusted Time Series": .monthly([:])
        ]
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        metaData = try container.decode(MetaData.self, forKey: DynamicKey(stringValue: "Meta Data")!)

        timeSeries = .intraday([:])

        for (key, type) in timeSeriesKeys {
            switch type {
            case .intraday:
                if let quotes = try? container.decode([String: IntradayQuote].self, forKey: DynamicKey(stringValue: key)!) {
                    timeSeries = .intraday(quotes)
                    return
                }
            case .daily:
                if let quotes = try? container.decode([String: DailyQuote].self, forKey: DynamicKey(stringValue: key)!) {
                    timeSeries = .daily(quotes)
                    return
                }

            case .weekly:
                if let quotes = try? container.decode([String: DailyQuote].self, forKey: DynamicKey(stringValue: key)!) {
                    timeSeries = .weekly(quotes)
                    return
                }
            case .monthly:
                if let quotes = try? container.decode([String: DailyQuote].self, forKey: DynamicKey(stringValue: key)!) {
                    timeSeries = .monthly(quotes)
                    return
                }
            }
        }

        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Time Series format not recognized"))
    }
}

private struct DynamicKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        self.intValue = intValue
        stringValue = "\(intValue)"
    }
}

struct IntradayQuote: Codable {
    let open, high, low, close, volume: String?
}

struct DailyQuote: Codable {
    let open, high, low, close: String?
    let adjustedClose: String?
    let volume: String?
    let dividendAmount: String?
    let splitCoefficient: String?
}

// MARK: - MetaData

// MARK: - MetaData
struct MetaData: Codable {
    let information: String
    let symbol: String
    let lastRefreshed: String
    let timeZone: String
    let outputSize: String?
    let interval: String?
    
    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case interval = "4. Interval"
        case outputSize = "5. Output Size"
        case timeZone = "6. Time Zone"
        
        // Handle the different time zone coding keys
        init?(stringValue: String) {
            switch stringValue {
            case "4. Time Zone":
                self = .timeZone
            default:
                self.init(rawValue: stringValue)
            }
        }
        
        var stringValue: String {
            switch self {
            case .timeZone:
                return rawValue
            default:
                return rawValue
            }
        }
        
        init?(intValue: Int) { return nil }
        var intValue: Int? { return nil }
    }
}

