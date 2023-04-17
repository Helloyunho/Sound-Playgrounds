//
//  GroupEditorView.swift
//  
//
//  Created by Helloyunho on 2023/04/12.
//

import SwiftUI

struct GroupEditorView: View {
    @ObservedObject var oscillator: OscillatorGroup
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            Group {
                OscillatorListView(oscillators: $oscillator.oscillators) { osc in
                    oscillator.remove(oscillator: osc)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                        }
                    }
                    ToolbarItemGroup(placement: .bottomBar) {
                        Menu {
                            Button {
                                let sineOscillator = SineOscillator()
                                oscillator.add(oscillator: sineOscillator)
                            } label: {
                                Label("Sine Oscillator", systemImage: "waveform.circle")
                            }
                            Button {
                                let sawtoothOscillator = SawtoothOscillator()
                                oscillator.add(oscillator: sawtoothOscillator)
                            } label: {
                                Label("Sawtooth Oscillator", systemImage: "waveform.circle")
                            }
                            Button {
                                let squareOscillator = SquareOscillator()
                                oscillator.add(oscillator: squareOscillator)
                            } label: {
                                Label("Square Oscillator", systemImage: "waveform.circle")
                            }
                            Button {
                                let triangleOscillator = TriangleOscillator()
                                oscillator.add(oscillator: triangleOscillator)
                            } label: {
                                Label("Triangle Oscillator", systemImage: "waveform.circle")
                            }
                            Button {
                                let noise = NoiseOscillator()
                                oscillator.add(oscillator: noise)
                            } label: {
                                Label("Noise", systemImage: "aqi.low")
                            }
                            Divider()
                            Button {
                                let group = OscillatorGroup()
                                oscillator.add(oscillator: group)
                            } label: {
                                Label("Group", systemImage: "play.square.stack.fill")
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        .navigationTitle(Text("Group Editor"))
        }
        .navigationViewStyle(.stack)
    }
}

struct GroupEditorView_Preview: View {
    var osc: OscillatorGroup = OscillatorGroup()
    var body: some View {
        GroupEditorView(oscillator: osc)
    }
}

struct GroupEditorView_Previews: PreviewProvider {
    static var previews: some View {
        GroupEditorView_Preview()
    }
}
