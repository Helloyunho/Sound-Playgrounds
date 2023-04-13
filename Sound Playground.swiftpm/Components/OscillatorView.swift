//
//  OscillatorView.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import SwiftUI

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
//            Text("\(self.phase)")
            ZStack {
                color.getSwiftUIGradient()
                WaveView(oscillator: oscillator, phase: phase)
                    .stroke(Color.white, lineWidth: 5) // TODO: Add animation to it
                Color.black.opacity(fingerOnIt ? 0.2 : 0)
                VStack {
                    Text(String(format: "%.2f", oscillator.amplitude))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text(String(format: "%.2f", oscillator.frequency))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .opacity(fingerOnIt ? 1 : 0.0001)
            }
            .frame(height: 128)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .gesture(
                !(
                    oscillator is OscillatorGroup
                ) ? DragGesture(minimumDistance: 5, coordinateSpace: .local)
                    .onChanged { value in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            fingerOnIt = true
                        }
                        if let initialProperties {
                            if value.translation.width > 0 {
                                let freq = initialProperties.1 + value.translation.width * 1.5
                                if freq < 20000 {
                                    oscillator.frequency = freq
                                } else {
                                    oscillator.frequency = 20000
                                }
                            } else if value.translation.width < 0 {
                                let freq = initialProperties.1 + value.translation.width * 1.5
                                if freq > 0 {
                                    oscillator.frequency = freq
                                } else {
                                    oscillator.frequency = 0
                                }
                            }
                            if value.translation.height < 0 {
                                let amp = initialProperties.0 - value.translation.height / 20
                                if amp < 1 {
                                    oscillator.amplitude = amp
                                } else {
                                    oscillator.amplitude = 1
                                }
                            } else if value.translation.height > 0 {
                                let amp = initialProperties.0 - value.translation.height / 20
                                if amp > 0 {
                                    oscillator.amplitude = amp
                                } else {
                                    oscillator.amplitude = 0
                                }
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
                    } : nil
            )
//            .onChange(of: oscillator.frequency) { freq in
//                self.phase = 1 / freq
//            }
            .task {
                while true {
                    withAnimation(.linear(duration: 5)) {
                        phase = 1
                    }
                    do {
                        try await Task.sleep(nanoseconds: 5 * 1000 * 1000 * 1000)
                    } catch {
                        break
                    }
                    phase = 0
                }
            }
        }
    }
}

struct OscillatorView_Preview: View {
    var oscillator = SawtoothOscillator(amplitude: 1, frequency: 30)
    var body: some View {
        OscillatorView(oscillator: oscillator, color: .blue)
    }
}

struct OscillatorView_Previews: PreviewProvider {
    static var previews: some View {
        OscillatorView_Preview()
    }
}
