//
//  Noise.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import Foundation

class NoiseOscillator: Oscillator {
    override func perform(_ time: Double) -> Double {
        return amplitude * Double.random(in: -1 ... 1)
    }
}
