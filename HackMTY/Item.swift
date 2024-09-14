//
//  Item.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
