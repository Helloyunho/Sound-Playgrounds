//
//  OscillatorGroup.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import Foundation
import AVFAudio

class OscillatorGroup: Oscillator {
    @Published var oscillators = [Oscillator]()
    
    func add(oscillator: Oscillator) {
        oscillators.append(oscillator)
    }
    
    func remove(oscillator: Oscillator) {
        oscillators.remove(element: oscillator)
    }
    
    override func perform(_ time: Double) -> Double {
        return oscillators.reduce(time) { partialResult, osc in
            return partialResult * osc.perform(time)
        }
    }
}
