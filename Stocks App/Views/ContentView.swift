//
//  ContentView.swift
//  Stocks App
//
//  Created by David Williams on 6/11/23.
//

import SwiftUI

struct ContentView: View {
    var stocks: [Stock] = [Stock.randomQuotes(), Stock.randomQuotes(), Stock.randomQuotes(), Stock.randomQuotes(), Stock.randomQuotes(), Stock.randomQuotes(), Stock.randomQuotes(), Stock.randomQuotes(), Stock.randomQuotes(), Stock.randomQuotes(), Stock.randomQuotes(), Stock.randomQuotes()]

    @State var query: String = ""

    var body: some View {
        NavigationStack {
            List(stocks) { stock in

                CellView(vm: CellViewModel(stock: stock))
            }
            .listStyle(.inset)
            .navigationTitle("Stocks")
            .searchable(text: $query)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
