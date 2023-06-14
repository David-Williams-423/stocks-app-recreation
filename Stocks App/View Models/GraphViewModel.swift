//
//  GraphViewModel.swift
//  Stocks App
//
//  Created by David Williams on 6/14/23.
//

import Foundation
import SwiftUI

class GraphViewModel: ObservableObject {
    @Published var quotes: [Quote]
    
    var thumbnail: Bool
    
    var timeRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let openingTime = calendar.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!
        let closingTime = calendar.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!
        return openingTime ... closingTime
    }
    
    init(quotes: [Quote], thumbnail: Bool) {
        self.quotes = quotes
        self.thumbnail = thumbnail
    }
    
    
}
