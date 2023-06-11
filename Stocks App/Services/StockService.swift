//
//  StockService.swift
//  Stocks App
//
//  Created by David Williams on 6/11/23.
//

import Foundation

class StockService {
    init() {
        if let API_KEY = ProcessInfo.processInfo.environment["API_KEY"] {
            print("Success")
        }
    }
}
