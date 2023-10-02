//
//  HomeViewModel.swift
//  Stocks App
//
//  Created by David Williams on 6/15/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var stocks: [Stock] = [Stock.randomQuotes()]
    @Published var searchQuery = ""
    @Published var secondaryInfo: SecondaryDailyInfo = .percentChange
    @Published var selectedStock: Stock?
    @Published var detailViewPresented: Bool = false

    var isSearching: Bool {
        !self.searchQuery.isEmpty
    }

    var subtitle: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        let today = Date()
        return dateFormatter.string(from: today)
    }

    var title = "Stocks"

    func deleteStock(at offsets: IndexSet) {
        self.stocks.remove(atOffsets: offsets)
    }

    func switchSecondaryInfo() {
        switch self.secondaryInfo {
        case .percentChange:
            self.secondaryInfo = .priceChange
        case .priceChange:
            self.secondaryInfo = .marketCap
        case .marketCap:
            self.secondaryInfo = .percentChange
        }
    }
}
