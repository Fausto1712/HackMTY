//
//  SwifDataModels.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftData
import SwiftUI

@Model
final class Expense : Identifiable {
    var id: Int
    var date: String
    var amount: Double
    var category: String
    var coordinates: [Double]
    var summary: String
    var title: String
    
    init(id: Int, date: String, amount: Double, category: String, coordinates: [Double], summary: String, title: String) {
        self.id = id
        self.date = date
        self.amount = amount
        self.category = category
        self.coordinates = coordinates
        self.summary = summary
        self.title = title
    }
}

struct Category: Identifiable {
    var id: UUID
    var color: Color
    var chartValue: CGFloat
    var name: String
    
    init(color: Color, chartValue: CGFloat, name: String) {
        self.id = UUID()
        self.color = color
        self.chartValue = chartValue
        self.name = name
    }
}
