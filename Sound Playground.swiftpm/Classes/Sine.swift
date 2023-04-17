//
//  Sine.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import Foundation

class SineOscillator: Oscillator {
    override func perform(_ time: Double) -> Double {
        return amplitude * sin(2.0 * Double.pi * frequency * (time + offset))
    }
}
