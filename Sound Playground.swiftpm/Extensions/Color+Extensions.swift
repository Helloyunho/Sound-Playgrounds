//
//  Color+Extensions.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import Foundation
import SwiftUI

public extension Color {
    init(rgba: UInt32) {
        self.init(
            red: CGFloat((rgba & 0xff00_0000) >> 24) / 255.0,
            green: CGFloat((rgba & 0x00ff_0000) >> 16) / 255.0,
            blue: CGFloat((rgba & 0x0000_ff00) >> 8) / 255.0,
            opacity: CGFloat(rgba & 0x0000_00ff) / 255.0
        )
    }
}
