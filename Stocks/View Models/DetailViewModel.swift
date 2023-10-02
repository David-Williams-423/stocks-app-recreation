//
//  DetailViewModel.swift
//  Stocks
//
//  Created by David Williams on 9/27/23.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var stock: Stock
    @Published var selectedTimeScale: TimeScale = .oneDay

    init(stock: Stock) {
        self.stock = stock
    }

    func isSelected(_ timeScale: TimeScale) -> Bool {
        return timeScale == selectedTimeScale
    }

    func select(_ timeScale: TimeScale) {
        selectedTimeScale = timeScale
    }
}
