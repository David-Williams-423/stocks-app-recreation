//
//  StocksApp.swift
//  Stocks
//
//  Created by David Williams on 6/11/23.
//

import SwiftUI

@main
struct StocksApp: App {

    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.dark)
        }
    }
}
