//
//  Sawtooth.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import Foundation

class SawtoothOscillator: Oscillator {
    override func perform(_ time: Double) -> Double {
        let period = 1.0 / frequency
        let currentTime = fmod(time + offset, period)
        return amplitude * ((currentTime / period) * 2 - 1.0)
    }
}
