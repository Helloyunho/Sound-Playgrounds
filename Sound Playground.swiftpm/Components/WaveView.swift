//
//  SwiftUIView.swift
//
//
//  Created by Helloyunho on 2023/04/07.
//

import SwiftUI

// Copied from https://www.hackingwithswift.com/plus/custom-swiftui-components/creating-a-waveview-to-draw-smooth-waveforms
struct WaveView: Shape {
    var oscillator: Oscillator
    var phase: Double
    var animatableData: Double {
        get { phase }
        set { phase = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        let width = Double(rect.width)
        let height = Double(rect.height)
        let midHeight = height / 2
        let wavelength = width
        let value = oscillator.perform(phase)
        let y = 20 * value + midHeight

        path.move(to: CGPoint(x: 0, y: y))

        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / wavelength
            let value = oscillator.perform(relativeX + phase)
            let y = 20 * value + midHeight

            path.addLine(to: CGPoint(x: x, y: y))
        }

        return Path(path.cgPath)
    }
}

struct WaveView_Preview: View {
    var oscillator = SineOscillator(amplitude: 1, frequency: 1, offset: 0)
    @State var phase: Double = 0
    var body: some View {
        WaveView(oscillator: oscillator, phase: self.phase)
            .stroke(Color.black, lineWidth: 5)
            .onAppear {
                withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
                    self.phase = oscillator.frequency
                }
            }
    }
}

struct WaveView_Previews: PreviewProvider {
    static var previews: some View {
        WaveView_Preview()
    }
}
