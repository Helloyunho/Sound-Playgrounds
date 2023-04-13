//
//  Array+Extensions.swift
//  
//
//  Created by Helloyunho on 2023/04/12.
//

import Foundation

extension Array where Element: Equatable {
    /// Remove first collection element that is equal to the given `object` or `element`:
    mutating func remove(element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
}
