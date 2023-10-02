//
//  ContentView.swift
//  Stocks App
//
//  Created by David Williams on 6/11/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    @State var isPresented: Bool = false
    @State var secondaryInfo: SecondaryDailyInfo = .percentChange

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.stocks) { stock in
                    CellView(vm: vm, stock: stock)
                }
                .onDelete { indexSet in
                    vm.deleteStock(at: indexSet)
                }
            }
            .listStyle(.inset)
            .searchable(text: $vm.searchQuery)
            .toolbar {
                titleBar
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        vm.stocks.append(Stock.randomQuotes())
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
        .sheet(item: $vm.selectedStock) { stock in
            DetailView(vm: DetailViewModel(stock: stock))
        }
    }

    private var titleBar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            VStack(alignment: .leading, spacing: -4) {
                Text(vm.title)
                Text(vm.subtitle).foregroundColor(Color(uiColor: .secondaryLabel))
            }.font(.title2.weight(.heavy))
                .padding(.bottom)
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
