//
//  Oscillator.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import Foundation
import AVFAudio

class Oscillator: Identifiable, ObservableObject, Equatable {
    static func == (lhs: Oscillator, rhs: Oscillator) -> Bool {
        lhs.id == rhs.id && lhs.amplitude == rhs.amplitude && lhs.frequency == rhs.frequency
    }
    
    @Published var amplitude: Double {
        didSet {
            if amplitude > 1 {
                amplitude = 1
            } else if amplitude < 0 {
                amplitude = 0
            }
        }
    }
    @Published var frequency: Double {
        didSet {
            if frequency > 20000 {
                frequency = 20000
            } else if frequency < 1 {
                frequency = 1
            }
        }
    }
    @Published var color: Colors
    var id: UUID
    
    convenience init() {
        self.init(amplitude: 1, frequency: 440, color: .allCases.randomElement()!)
    }
    
    convenience init(amplitude: Double, frequency: Double) {
        self.init(amplitude: amplitude, frequency: frequency, color: .allCases.randomElement()!)
    }
    
    init(amplitude: Double, frequency: Double, color: Colors) {
        self.amplitude = amplitude
        self.frequency = frequency
        self.id = UUID()
        self.color = color
    }
    
    func perform(_ time: Double) -> Double {
        // don't do anything by default
        return time
    }
}
