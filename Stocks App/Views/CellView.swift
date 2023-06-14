//
//  CellView.swift
//  Stocks App
//
//  Created by David Williams on 6/11/23.
//

import Charts
import SwiftUI

struct CellView: View {
    @StateObject var vm: CellViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(vm.stock.ticker)
                    .font(.title3).bold()
                Text(vm.stock.name)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
            }
            Spacer()

            GraphView(vm: GraphViewModel(quotes: vm.stock.intraDayQuotes, thumbnail: true))
                .frame(width: 75, height: 40)
                .padding(.trailing)
                
            VStack(alignment: .trailing, spacing: 5) {
                Text(vm.price)
                    .font(.title3).monospacedDigit().bold()

                ZStack(alignment: .trailing) {
                    Rectangle()
                        .frame(width: 80, height: 27)
                        .cornerRadius(5)
                        .foregroundColor(FinancialFormatting.getColor(quotes: vm.stock.intraDayQuotes))
                    Text(vm.secondaryInfo.get())
                        .font(.subheadline).fontWeight(.medium)
                        .monospacedDigit()
                        .padding(.horizontal, 5)
                }
            }
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(vm: CellViewModel(stock: .example))
            .preferredColorScheme(.dark)
    }
}

//
//#Preview {
//    CellView(vm: CellViewModel(stock: .example))
//        .preferredColorScheme(.dark)
//}
