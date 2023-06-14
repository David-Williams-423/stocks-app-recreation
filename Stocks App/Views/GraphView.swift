//
//  GraphView.swift
//  Stocks App
//
//  Created by David Williams on 6/14/23.
//

import Charts
import SwiftUI

struct GraphView: View {
    @StateObject var vm: GraphViewModel

    var body: some View {
        if vm.thumbnail {
            chart
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                

        } else {
            chart
                .chartPlotStyle { createPlotStyle($0) }
        }
    }

    private var chart: some View {
        let graphColor = FinancialFormatting.getColor(quotes: vm.quotes)
        let previousClose = vm.quotes.first!.close
        let chart = Chart {
            ForEach(vm.quotes, id: \.datetime) { quote in
                LineMark(
                    x: .value("Time", quote.datetime),
                    y: .value("Price", quote.close)
                )
                .foregroundStyle(graphColor)

                AreaMark(x: .value("Time", quote.datetime), yStart: .value("Min", Quote.min(vm.quotes)), yEnd: .value("Max", quote.close))
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [graphColor, graphColor.opacity(0.01)]), startPoint: .top, endPoint: .bottom).opacity(0.8))
                if vm.thumbnail {
                    RuleMark(
                        
                        y: .value("Price", previousClose)
                    )
                    .lineStyle(.init(lineWidth: 1, dash: [4, 2]))
                    .foregroundStyle(graphColor)

                }
            }
        }
        .chartXScale(domain: vm.timeRange)
        .chartYScale(domain: Quote.priceRange(quotes: vm.quotes))

        return chart
    }

    private func createPlotStyle(_ context: ChartPlotContent) -> some View {
        context
            .overlay {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.5))
                    .mask(ZStack {
                        VStack {
                            Spacer()
                            Rectangle().frame(height: 1)
                        }

                        HStack {
                            Spacer()
                            Rectangle().frame(width: 0.3)
                        }
                    })
            }
    }
}

#Preview {
    GraphView(vm: GraphViewModel(quotes: Quote.generateQuotes(startPrice: 420.0), thumbnail: true))
}
