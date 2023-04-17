//
//  OscillatorGroup.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import AVFAudio
import Foundation

class OscillatorGroup: Oscillator {
    @Published var oscillators = [Oscillator]()
    
    convenience init() {
        self.init(amplitude: 1, frequency: 1, offset: 0)
    }
    
    func add(oscillator: Oscillator) {
        oscillators.append(oscillator)
    }
    
    func remove(oscillator: Oscillator) {
        oscillators.remove(element: oscillator)
    }
    
    override func perform(_ time: Double) -> Double {
        if oscillators.count == 0 {
            return 0
        } else {
            return oscillators.reduce(1) { partialResult, osc in
                let result = partialResult * osc.perform((time + offset) * frequency)
                return result
            } * amplitude
        }
    }
}
