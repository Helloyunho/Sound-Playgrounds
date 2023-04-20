//
//  Oscillator.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import AVFAudio
import Foundation

// Based on https://github.com/GrantJEmerson/SwiftSynth/blob/master/Swift%20Synth/Audio/Oscillator.swift
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

    @Published var offset: Double
    @Published var color: Colors
    var id: UUID

    convenience init() {
        self.init(amplitude: 1, frequency: 440, color: .allCases.randomElement()!, offset: 0)
    }

    convenience init(amplitude: Double, frequency: Double, offset: Double) {
        self.init(amplitude: amplitude, frequency: frequency, color: .allCases.randomElement()!, offset: offset)
    }

    init(amplitude: Double, frequency: Double, color: Colors, offset: Double) {
        self.amplitude = amplitude
        self.frequency = frequency
        self.id = UUID()
        self.color = color
        self.offset = offset
    }

    // just return time + offset for default
    func perform(_ time: Double) -> Double {
        return time + offset
    }
}
