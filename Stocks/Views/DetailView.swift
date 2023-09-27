//
//  DetailView.swift
//  Stocks App
//
//  Created by David Williams on 6/16/23.
//

import SwiftUI

struct DetailView: View {
    var stock: Stock
    var body: some View {
        VStack {
            header
            
            currentPrice
                .padding(.horizontal)
            Divider()
            Spacer()
        }
    }

    private var header: some View {
        VStack(spacing: 10) {
            HStack(alignment: .bottom) {
                Text(stock.ticker)
                    .font(.title).fontWeight(.heavy)
                Text(stock.name)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.bottom, 3)
                Spacer()
                Image(systemName: "ellipsis.circle.fill")
                    .foregroundStyle(.blue, .quaternary)
                    .font(.title)
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.gray, .quaternary)
                    .font(.title)
            }
            .padding([.horizontal, .top])
            Divider()
        }
    }

    private var currentPrice: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    let color = FinancialFormatting.getColor(quotes: stock.intraDayQuotes)

                    Text(FinancialFormatting.formatPrice(stock.price, signed: false))
                        .bold()
                        .padding(.trailing)

                    Text(FinancialFormatting.formatPercent(stock.percentChange))
                        .foregroundStyle(color)
                }
                HStack {
                    Text(stock.exchange + " ‧ " + stock.currency)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    HomeView()
        .sheet(isPresented: .constant(true)) {
            DetailView(stock: Stock.example)
                .preferredColorScheme(.dark)
        }
        .preferredColorScheme(.dark)
}
