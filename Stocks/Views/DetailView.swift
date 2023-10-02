//
//  DetailView.swift
//  Stocks App
//
//  Created by David Williams on 6/16/23.
//

import SwiftUI

struct DetailView: View {
    @StateObject var vm: DetailViewModel
    var body: some View {
        VStack {
            header
            currentPrice
                .padding(.horizontal)
            Divider()
            timeScales
                .padding(.horizontal)
            graph
            fundamentals
                .padding(.horizontal)
            Spacer()
        }
    }

    private var header: some View {
        VStack(spacing: 10) {
            HStack(alignment: .bottom) {
                Text(vm.stock.ticker)
                    .font(.title).fontWeight(.heavy)
                Text(vm.stock.name)
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
                    let color = FinancialFormatting.getColor(quotes: vm.stock.intraDayQuotes)

                    Text(FinancialFormatting.formatPrice(vm.stock.price, signed: false))
                        .bold()
                        .padding(.trailing)

                    Text(FinancialFormatting.formatPercent(vm.stock.percentChange))
                        .foregroundStyle(color)
                }
                HStack {
                    Text(vm.stock.exchange + " ‧ " + vm.stock.currency)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
        }
    }

    private var timeScales: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(TimeScale.allCases, id: \.self) { timeScale in
                    Text(timeScale.textRepresentation())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(vm.isSelected(timeScale) ? Color.gray.opacity(0.2) : .clear)
                        .bold(vm.isSelected(timeScale))
                        .cornerRadius(10)
                        .onTapGesture {
                            vm.select(timeScale)
                        }
                }
            }
        }
    }

    private var graph: some View {
        GraphView(vm: GraphViewModel(quotes: vm.stock.intraDayQuotes, thumbnail: false))
            .frame(height: 350)
    }

    private var fundamentals: some View {
        let stock = vm.stock
        let section1 = [
            ("Open", FinancialFormatting.formatPrice(stock.fundamental.open)),
            ("High", FinancialFormatting.formatPrice(stock.fundamental.high)),
            ("Low", FinancialFormatting.formatPrice(stock.fundamental.low))
        ]
        let section2 = [
            ("Vol", FinancialFormatting.formatLargeNumber(stock.fundamental.volume)),
            ("P/E", FinancialFormatting.formatPrice(stock.fundamental.peRatio)),
            ("Mkt Cap", FinancialFormatting.formatLargeNumber(stock.fundamental.marketCap))
        ]
        let section3 = [
            ("52W H", FinancialFormatting.formatPrice(stock.fundamental.yearHigh)),
            ("52W L", FinancialFormatting.formatPrice(stock.fundamental.yearLow)),
            ("Avg Vol", FinancialFormatting.formatLargeNumber(stock.fundamental.avgVolume))
        ]
        let section4 = [
            ("Yield", FinancialFormatting.formatPercent(stock.fundamental.yield, signed: false)),
            ("Beta", FinancialFormatting.formatPrice(stock.fundamental.beta)),
            ("EPS", FinancialFormatting.formatPrice(stock.fundamental.EPS))
        ]

        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                fundamentalSection(values: section1)
                verticalDivider
                fundamentalSection(values: section2)
                verticalDivider
                fundamentalSection(values: section3)
                verticalDivider
                fundamentalSection(values: section4)
            }
        }
    }

    private var verticalDivider: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 1, height: 60)
    }

    private func fundamentalSection(values: [(String, String)]) -> some View {
        VStack(alignment: .leading) {
            ForEach(values, id: \.0) { key, value in
                HStack {
                    Text(key)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(value)
                        .monospacedDigit()
                        .font(.footnote)
                }
            }
        }
        .frame(width: 110)
    }
}

#Preview {
    HomeView()
        .sheet(isPresented: .constant(true)) {
            DetailView(vm: DetailViewModel(stock: Stock.example))
                .preferredColorScheme(.dark)
        }
        .preferredColorScheme(.dark)
}
