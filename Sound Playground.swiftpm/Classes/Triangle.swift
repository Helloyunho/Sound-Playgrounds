//
//  Triangle.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import Foundation
import SwiftUI

// Based on https://github.com/GrantJEmerson/SwiftSynth/blob/master/Swift%20Synth/Audio/Oscillator.swift
class TriangleOscillator: Oscillator {
    override func perform(_ time: Double) -> Double {
        let period = 1.0 / frequency
        let currentTime = fmod(time, period)
        
        let value = currentTime / period
        
        var result = 0.0
        if value < 0.25 {
            result = value * 4
        } else if value < 0.75 {
            result = 2.0 - (value * 4.0)
        } else {
            result = value * 4 - 4.0
        }
        
        return amplitude * result
    }
}
