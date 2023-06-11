//
//  Stocks_AppApp.swift
//  Stocks App
//
//  Created by David Williams on 6/11/23.
//

import SwiftUI

@main
struct Stocks_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
