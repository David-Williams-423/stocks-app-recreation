//
//  Stock.swift
//  Stocks App
//
//  Created by David Williams on 6/12/23.
//

import Foundation

struct Stock: Identifiable {
    var id = UUID()
    var ticker: String
    var name: String
    var exchange: String = "NASDAQ"
    var currency: String = "USD"
    var previousClose: Double {
        intraDayQuotes.first!.close
    }

    var price: Double {
        intraDayQuotes.last!.close
    }

    var percentChange: Double {
        (price - previousClose) / previousClose
    }

    var intraDayQuotes: [Quote]
    var fundamental: FundamentalData
}

struct Quote {
    var datetime: Date
    var close: Double
    var volume: Int
}

struct FundamentalData {
    var open: Double
    var high: Double
    var low: Double
    var volume: Int
    var peRatio: Double
    var marketCap: Int
    var yearHigh: Double
    var yearLow: Double
    var avgVolume: Int
    var yield: Double
    var beta: Double
    var EPS: Double
}

extension Stock {
    static func randomQuotes() -> Stock {
        Stock(ticker: "NVDA", name: "NVIDIA Corporation", intraDayQuotes: Quote.generateQuotes(startPrice: 429.97), fundamental: FundamentalData.example)
    }

    static var example: Stock = .init(ticker: "NVDA", name: "NVIDIA Corporation", intraDayQuotes: Quote.generateQuotes(startPrice: 429.97), fundamental: FundamentalData.example)
}

extension Quote {
    static func generateQuotes(startPrice: Double) -> [Quote] {
        let calendar = Calendar.current
        var quotes: [Quote] = []

        guard let openingTime = calendar.date(bySettingHour: 9, minute: 30, second: 0, of: Date()) else { return quotes }
        guard let closingTime = calendar.date(bySettingHour: 16, minute: 0, second: 0, of: Date()) else { return quotes }

        var time = openingTime
        var price = startPrice

        while time <= closingTime {
            let volume = Int.random(in: 100 ... 1000)
            let quote = Quote(datetime: time, close: price, volume: volume)
            quotes.append(quote)

            // increment the time by one minute
            guard let newTime = calendar.date(byAdding: .minute, value: 5, to: time) else { break }
            time = newTime

            // modify the price by a random amount
            price += Double.random(in: -0.005 * price ... 0.005 * price)
        }

        return quotes
    }

    static func priceRange(quotes: [Quote]) -> ClosedRange<Double> {
        var minClose = quotes.first!.close
        var maxClose = quotes.last!.close

        for quote in quotes {
            if quote.close < minClose {
                minClose = quote.close
            }

            if quote.close > maxClose {
                maxClose = quote.close
            }
        }
        return minClose * 0.99 ... maxClose * 1.01
    }

    static func min(_ quotes: [Quote]) -> Double {
        var minClose = quotes.first!.close
        for quote in quotes {
            if quote.close < minClose {
                minClose = quote.close
            }
        }
        return minClose
    }

    static func max(_ quotes: [Quote]) -> Double {
        var maxClose = quotes.first!.close
        for quote in quotes {
            if quote.close > maxClose {
                maxClose = quote.close
            }
        }
        return maxClose
    }
}

extension FundamentalData {
    static var example: FundamentalData = .init(open: 412.43, high: 421.52, low: 408.02, volume: 29523943, peRatio: 215.69, marketCap: 1033000000000, yearHigh: 422.76, yearLow: 108.13, avgVolume: 47710000, yield: 0.0004, beta: 1.77, EPS: 1.94)
}
