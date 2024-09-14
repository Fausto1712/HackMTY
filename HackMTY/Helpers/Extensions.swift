//
//  Extensions.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI

extension Color {
    static var availableColorNames: [String] {
        Array(colorMap.keys)
    }
    
    init?(name: String) {
        guard let color = Self.colorMap[name] else {
            return nil
        }
        self = color
    }
    
    private static let colorMap: [String: Color] = [
        "red": .red,
        "green": .green,
        "blue": .blue,
        "yellow": .yellow,
        "orange": .orange,
        "pink": .pink,
        "purple": .purple,
        "gray": .gray,
        "brown": .brown,
        "black": .black,
        "cyan": .cyan,
        "indigo": .indigo,
        "mint": .mint,
        "teal": .teal,
        "primary": .primary
    ]
}
