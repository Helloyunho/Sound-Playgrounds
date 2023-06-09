//
//  OscillatorView.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import SwiftUI

let keys = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

struct OscillatorView: View {
    @ObservedObject var oscillator: Oscillator
    var color: Colors
    @State var phase: Double = 0
    @State var fingerOnIt = false
    @State var openDrawer = false
    @State var doWave = true
    @State var initialProperties: (Double, Double)? = nil
    var body: some View {
        VStack {
            ZStack {
                color.getSwiftUIGradient()
                WaveView(oscillator: oscillator, phase: phase)
                    .stroke(Color.white, lineWidth: 5)
                VStack(spacing: 4) {
                    Spacer()
                    if oscillator is NoiseOscillator {
                        Text("Noise")
                    } else if oscillator is OscillatorGroup {
                        Text("Group")
                    } else if oscillator is SawtoothOscillator {
                        Text("Sawtooth")
                    } else if oscillator is SineOscillator {
                        Text("Sine")
                    } else if oscillator is SquareOscillator {
                        Text("Square")
                    } else if oscillator is TriangleOscillator {
                        Text("Triangle")
                    }
                    TicksView()
                        .stroke(Color.white.opacity(0.6), lineWidth: 4)
                        .frame(height: 12)
                    // each tick means one note change (ex. C -> C#)
                }
                Color.black.opacity(fingerOnIt ? 0.3 : 0)
                VStack {
                    Text(String(format: "%.2f%%", oscillator.amplitude * 100))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    if oscillator is OscillatorGroup {
                        Text(String(format: "%.2fx", oscillator.frequency))
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    } else {
                        Text(String(format: "%.2f Hz (%@%d)", oscillator.frequency, keys[Int((12 * log2(oscillator.frequency / 440)).rounded(.toNearestOrEven)) %% 12], Int(log2(oscillator.frequency / 440) + 9.5 / 12) + 4))
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                .opacity(fingerOnIt ? 1 : 0.0001)
            }
            .frame(height: 128)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .gesture(
                DragGesture(minimumDistance: 5, coordinateSpace: .local)
                    .onChanged { value in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            fingerOnIt = true
                        }
                        if let initialProperties {
                            if value.translation.width != 0 {
                                if oscillator is OscillatorGroup {
                                    oscillator.frequency = initialProperties.1 + value.translation.width / 2
                                } else {
                                    oscillator.frequency = pow(2, log2(initialProperties.1) + value.translation.width / 400)
                                }
                            }
                            if value.translation.height != 0 {
                                oscillator.amplitude = initialProperties.0 - value.translation.height / 40
                            }
                        } else {
                            initialProperties = (oscillator.amplitude, oscillator.frequency)
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            fingerOnIt = false
                        }
                        if initialProperties != nil {
                            self.initialProperties = nil
                        }
                    }
            )
            .task {
                while true {
                    withAnimation(.linear(duration: 1)) {
                        phase = 1 / oscillator.frequency
                    }

                    try? await Task.sleep(nanoseconds: 1 * 1000 * 1000 * 1000)
                    phase = 0
                }
                // repeatForever doesn't follow changes made to frequency
                // dirty hack but it works :D
            }
        }
    }
}

struct OscillatorView_Preview: View {
    var oscillator = SawtoothOscillator(amplitude: 1, frequency: 30, offset: 0)
    var body: some View {
        OscillatorView(oscillator: oscillator, color: .blue)
    }
}

struct OscillatorView_Previews: PreviewProvider {
    static var previews: some View {
        OscillatorView_Preview()
    }
}
