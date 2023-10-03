////
////  StockService.swift
////  Stocks App
////
////  Created by David Williams on 6/11/23.
////
//

import Foundation

class StockService {
    
    static let key: String = {
            // Default value
            var loadedKey: String = ""

            // Try to load the API key from "api_key.json"
            if let url = Bundle.main.url(forResource: "api_key", withExtension: "json"),
               let data = try? Data(contentsOf: url),
               let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                loadedKey = json["api_key"] as? String ?? ""
            }
            return loadedKey
        }()
    
    static func fetchIntradayQuotes() async throws -> IntradayQuotes {
        
        
        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=\(key)")!
        
        // Use URLSession's new data(from:) method which returns Data
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the data into IntradayQuotes object
        let decoder = JSONDecoder()
        let intradayQuotes = try decoder.decode(IntradayQuotes.self, from: data)
        
        print(intradayQuotes)
        return intradayQuotes
    }
    
    static func fetchCompanyOverview() async throws -> CompanyOverview {
        
        print(key)
        let url = URL(string: "https://www.alphavantage.co/query?function=OVERVIEW&symbol=NVDA&apikey=\(key)")!
        
        // Use URLSession's new data(from:) method which returns Data
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the data into IntradayQuotes object
        let decoder = JSONDecoder()
        let companyOverview = try decoder.decode(CompanyOverview.self, from: data)
        
        print(key)
        return companyOverview
    }
    
    static func fetchSearchResults() async throws -> SearchResults {
        let url = URL(string: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=BA&apikey=demo")!
        
        // Use URLSession's new data(from:) method which returns Data
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the data into IntradayQuotes object
        let decoder = JSONDecoder()
        let searchResults = try decoder.decode(SearchResults.self, from: data)
        
        return searchResults
    }
}
