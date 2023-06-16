//
//  ContentView.swift
//  Stocks App
//
//  Created by David Williams on 6/11/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    var body: some View {
        NavigationStack {
            List(vm.stocks) { stock in
                CellView(vm: CellViewModel(stock: stock), isSearching: vm.isSearching)
            }
            .listStyle(.inset)
            .toolbar {
                titleBar
            }
            .searchable(text: $vm.searchQuery)
        }
    }

    private var titleBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
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
