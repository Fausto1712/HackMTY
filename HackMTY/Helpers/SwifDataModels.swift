//
//  SwifDataModels.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftData
import MapKit
import SwiftUI

@Model
final class Category : Identifiable {
    var id: UUID
    var color: String
    var opacity: Double
    var budgetLimit: Double
    var currentExpense: Double
    var chartValue: CGFloat
    var name: String
    var iconName: String
    
    init(color: String,opacity: Double, budgetLimit: Double, currentExpense: Double, name: String, iconName: String) {
        self.id = UUID()
        self.color = color
        self.opacity = opacity
        self.budgetLimit = budgetLimit
        self.currentExpense = currentExpense
        self.chartValue = CGFloat(currentExpense)
        self.name = name
        self.iconName = iconName
    }
}

@Model
final class Expense : Identifiable {
    var id: Int
    var date: String
    var amount: Double
    var category: String
    var locationName: String
    var coordinates: [Double]
    var summary: String
    var title: String
    
    init(id: Int, date: String, amount: Double, category: String,  desc: String, coordinates: [Double], summary: String, title: String) {
        self.id = id
        self.date = date
        self.amount = amount
        self.category = category
        self.locationName = desc
        self.coordinates = coordinates
        self.summary = summary
        self.title = title
    }
}
