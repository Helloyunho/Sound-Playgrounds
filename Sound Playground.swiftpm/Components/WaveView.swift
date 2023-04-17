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
        set { self.phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        // calculate some important values up front
        let width = Double(rect.width)
        let height = Double(rect.height)
//        let midWidth = width / 2
        let midHeight = height / 2

        // split our total width up based on the frequency
        let wavelength = width
        
        let value = oscillator.perform(phase)

        // multiply that sine by our strength to determine final offset, then move it down to the middle of our view
        let y = 20 * value + midHeight

        // start at the left center
        path.move(to: CGPoint(x: 0, y: y))

//         now count across individual horizontal points one by one
        for x in stride(from: 0, through: width, by: 1) {
            // find our current position relative to the wavelength
            let relativeX = x / wavelength

            // calculate the sine of that position
            let value = oscillator.perform(relativeX + phase)

            // multiply that sine by our strength to determine final offset, then move it down to the middle of our view
            let y = 20 * value + midHeight

            // add a line to here
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
