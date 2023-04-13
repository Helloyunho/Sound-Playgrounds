//
//  Colors.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import Foundation
import SwiftUI

enum Colors: CaseIterable {
    case red, blue, green, purple, pink, yellow, cyan, black, orange, gray
}

extension Colors {
    func getSwiftUIGradient() -> LinearGradient {
        switch self {
        case .red:
            return .init(colors: [.init(rgba: 0xE87D7DFF), .init(rgba: 0xDB5757FF)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .blue:
            return .init(colors: [.init(rgba: 0x5469B8FF), .init(rgba: 0x3951ADFF)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .green:
            return .init(colors: [.init(rgba: 0x44C8AEFF), .init(rgba: 0x26BFA1FF)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .purple:
            return .init(colors: [.init(rgba: 0x805DB4FF), .init(rgba: 0x6C43A8FF)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .pink:
            return .init(colors: [.init(rgba: 0xDE8CC9FF), .init(rgba: 0xD979C0FF)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .yellow:
            return .init(colors: [.init(rgba: 0xE9AB65FF), .init(rgba: 0xE69D4CFF)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .cyan:
            return .init(colors: [.init(rgba: 0x56C5D7FF), .init(rgba: 0x3BBCD1FF)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .black:
            return .init(colors: [.init(rgba: 0x2A2C2BFF), .init(rgba: 0x191E1FFF)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .orange:
            return .init(colors: [.init(rgba: 0xEE8D72FF), .init(rgba: 0xEB7B5BFF)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .gray:
            return .init(colors: [.init(rgba: 0x8C939CFF), .init(rgba: 0x79828CFF)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
    func getSwiftUIColor() -> Color {
        switch self {
        case .red:
            return .init(rgba: 0xDB5757FF)
        case .blue:
            return .init(rgba: 0x3951ADFF)
        case .green:
            return .init(rgba: 0x26BFA1FF)
        case .purple:
            return .init(rgba: 0x6C43A8FF)
        case .pink:
            return .init(rgba: 0xD979C0FF)
        case .yellow:
            return .init(rgba: 0xE69D4CFF)
        case .cyan:
            return .init(rgba: 0x3BBCD1FF)
        case .black:
            return .init(rgba: 0x191E1FFF)
        case .orange:
            return .init(rgba: 0xEB7B5BFF)
        case .gray:
            return .init(rgba: 0x79828CFF)
        }
    }
}
