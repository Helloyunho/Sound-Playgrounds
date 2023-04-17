//
//  MainView.swift
//
//
//  Created by Helloyunho on 2023/04/11.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainAudio = MainAudio()
    @State var showFeaturesSheet = false
    var body: some View {
        NavigationView {
            OscillatorListView(oscillators: $mainAudio.oscillators) { osc in
                mainAudio.remove(oscillator: osc)
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        if mainAudio.isPlaying {
                            mainAudio.pause()
                        } else {
                            mainAudio.play()
                        }
                    } label: {
                        if mainAudio.isPlaying {
                            Image(systemName: "pause.fill")
                                .resizable()
                        } else {
                            Image(systemName: "play.fill")
                                .resizable()
                        }
                    }
                    Menu {
                        Button {
                            let sineOscillator = SineOscillator()
                            mainAudio.add(oscillator: sineOscillator)
                        } label: {
                            Label("Sine Oscillator", systemImage: "waveform.circle")
                        }
                        Button {
                            let sawtoothOscillator = SawtoothOscillator()
                            mainAudio.add(oscillator: sawtoothOscillator)
                        } label: {
                            Label("Sawtooth Oscillator", systemImage: "waveform.circle")
                        }
                        Button {
                            let squareOscillator = SquareOscillator()
                            mainAudio.add(oscillator: squareOscillator)
                        } label: {
                            Label("Square Oscillator", systemImage: "waveform.circle")
                        }
                        Button {
                            let triangleOscillator = TriangleOscillator()
                            mainAudio.add(oscillator: triangleOscillator)
                        } label: {
                            Label("Triangle Oscillator", systemImage: "waveform.circle")
                        }
                        Button {
                            let noise = NoiseOscillator()
                            mainAudio.add(oscillator: noise)
                        } label: {
                            Label("Noise", systemImage: "aqi.low")
                        }
                        Divider()
                        Button {
                            let group = OscillatorGroup()
                            mainAudio.add(oscillator: group)
                        } label: {
                            Label("Group", systemImage: "play.square.stack.fill")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle(Text("Sound Playgrounds"))
        }
        .onAppear {
            let defaults = UserDefaults.standard
            if !defaults.bool(forKey: "notFirstRun") {
                showFeaturesSheet = true
            }
        }
        .sheet(isPresented: $showFeaturesSheet) {
            WelcomeView()
        }
        .navigationViewStyle(.stack)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
