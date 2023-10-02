//
//  CellView.swift
//  Stocks App
//
//  Created by David Williams on 6/11/23.
//

import Charts
import SwiftUI

struct CellView: View {
    @StateObject var vm: HomeViewModel
    @State var added: Bool = false
    var stock: Stock
    var body: some View {
        HStack {
            if vm.isSearching {
                addStock
            }

            Group {
                leftSide

                Spacer()

                if !vm.isSearching {
                    GraphView(vm: GraphViewModel(quotes: stock.intraDayQuotes, thumbnail: true))
                        .frame(width: 70, height: 50)
                        .padding(.trailing)
                }
            }
            .onTapGesture {
                vm.selectedStock = stock
            }

            rightSide
                .onTapGesture {
                    vm.switchSecondaryInfo()
                }
        }
    }

    private var addStock: some View {
        Button {
            added.toggle()
        } label: {
            if added {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.white, .blue)

            } else {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.blue, .quaternary)
            }
        }
        .font(.title2)
        .padding(.horizontal, 5)
    }

    private var leftSide: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(stock.ticker)
                .font(.title3).bold()

            Text(stock.name)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
        }
    }

    private var rightSide: some View {
        let color = FinancialFormatting.getColor(quotes: stock.intraDayQuotes)
        return VStack(alignment: .trailing, spacing: 2) {
            Text(FinancialFormatting.formatPrice(stock.price, lowerBound: 5.0, upperBound: 99999.99, signed: false))
                .font(.headline).monospacedDigit().bold()

            ZStack(alignment: .trailing) {
                if !vm.isSearching {
                    Rectangle()
                        .frame(width: 65, height: 25)
                        .cornerRadius(5)
                        .foregroundColor(color)
                }

                Text(vm.secondaryInfo.get(stock: stock))
                    .font(vm.isSearching ? .headline : .footnote).fontWeight(.medium)
                    .monospacedDigit()
                    .padding(.horizontal, vm.isSearching ? 0 : 5)
                    .foregroundStyle(vm.isSearching ? color : .white)
            }
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var vm = HomeViewModel()
    static var previews: some View {
        CellView(vm: vm, stock: Stock.example)
            .preferredColorScheme(.dark)
    }
}

//
// #Preview {
//    CellView(vm: CellViewModel(stock: .example))
//        .preferredColorScheme(.dark)
// }
