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


extension Font {
    // Custom Figtree Variable Font with specific weight categories
    static func figtree(size: CGFloat, weight: FigtreeWeight = .regular) -> Font {
        // Apply specific weight based on FigtreeWeight enum
        switch weight {
        case .regular:
            return Font.custom("Figtree", size: size)
        case .medium:
            return Font.custom("Figtree", size: size).weight(.medium)
        case .semiBold:
            return Font.custom("Figtree", size: size).weight(.semibold)
        case .bold:
            return Font.custom("Figtree", size: size).weight(.bold)
        }
    }

    // Dynamic Type scaling using predefined Apple styles for specific weights
    static func figtreeDynamic(_ textStyle: Font.TextStyle, weight: FigtreeWeight = .regular) -> Font {
        let size = UIFont.preferredFont(forTextStyle: UIFont.TextStyle(textStyle)).pointSize
        return figtree(size: size, weight: weight)
    }
}

// Enum to handle Figtree font weights
enum FigtreeWeight {
    case regular
    case medium
    case semiBold
    case bold
}

extension Font {
    
    // Poppins-Bold font
    static func poppinsBold(size: CGFloat) -> Font {
        return Font.custom("Poppins-Bold", size: size)
    }

    // Poppins-Semibold font
    static func poppinsSemibold(size: CGFloat) -> Font {
        return Font.custom("Poppins-SemiBold", size: size)
    }

    // Dynamic Poppins-Bold using text style
    static func poppinsBoldDynamic(_ textStyle: Font.TextStyle) -> Font {
        let size = UIFont.preferredFont(forTextStyle: UIFont.TextStyle(textStyle)).pointSize
        return poppinsBold(size: size)
    }

    // Dynamic Poppins-Semibold using text style
    static func poppinsSemiboldDynamic(_ textStyle: Font.TextStyle) -> Font {
        let size = UIFont.preferredFont(forTextStyle: UIFont.TextStyle(textStyle)).pointSize
        return poppinsSemibold(size: size)
    }
}

extension UIFont.TextStyle {
    init(_ textStyle: Font.TextStyle) {
        switch textStyle {
        case .largeTitle: self = .largeTitle
        case .title: self = .title1
        case .title2: self = .title2
        case .title3: self = .title3
        case .headline: self = .headline
        case .subheadline: self = .subheadline
        case .callout: self = .callout
        case .body: self = .body
        case .footnote: self = .footnote
        case .caption: self = .caption1
        case .caption2: self = .caption2
        default: self = .body
        }
    }
}
