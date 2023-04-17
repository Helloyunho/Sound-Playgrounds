//
//  Square.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import Foundation

class SquareOscillator: Oscillator {
    override func perform(_ time: Double) -> Double {
        let period = 1.0 / frequency
        let currentTime = fmod(time + offset, period)
        return ((currentTime / period) < 0.5) ? amplitude : -1.0 * amplitude
    }
}
