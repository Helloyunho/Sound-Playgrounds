//
//  OscillatorListView.swift
//  
//
//  Created by Helloyunho on 2023/04/10.
//

import SwiftUI

struct OscillatorListView: View {
    @Binding var oscillators: [Oscillator]
    @State var showGroupEditorFor: OscillatorGroup? = nil
    @State var showGroupEditor = false
    @State var showFrequencyEditor = false
    @State var showAmplitudeEditor = false
    @State var showDeleteAlert = false
    @State var selectedOscillator: Oscillator? = nil
    @State var frequency = ""
    @State var amplitude = ""
    var onDelete: (Oscillator) -> Void = { _ in }
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(oscillators, id: \.id) { oscillator in
                    OscillatorView(oscillator: oscillator, color: oscillator.color)
                        .onTapGesture {
                            if let oscillator = oscillator as? OscillatorGroup {
                                self.showGroupEditor = true
                                self.showGroupEditorFor = oscillator
                            }
                        }
                        .contextMenu {
                            if let oscGroup = oscillator as? OscillatorGroup {
                                Button {
                                    showGroupEditor = true
                                    showGroupEditorFor = oscGroup
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                            }
                            Button {
                                showFrequencyEditor = true
                                selectedOscillator = oscillator
                            } label: {
                                Label(oscillator is OscillatorGroup ? "Set Relative Frequency" : "Set Frequency", systemImage: "waveform")
                            }
                            Button {
                                showAmplitudeEditor = true
                                selectedOscillator = oscillator
                            } label: {
                                Label("Set Amplitude", systemImage: "speaker.wave.2.circle")
                            }
                            Divider()
                            Button(role: .destructive) {
                                showDeleteAlert = true
                                selectedOscillator = oscillator
                            } label: {
                                Label("Delete", systemImage: "trash.slash")
                            }
                        }
                }
                Spacer()
            }
        }
        .padding()
        .sheet(isPresented: $showGroupEditor) {
            Group {
                if let showGroupEditorFor {
                    GroupEditorView(oscillator: showGroupEditorFor)
                } else {
                    Text("Please wait...")
                }
            }
        }
        .alert("Set Frequency", isPresented: $showFrequencyEditor) {
            TextField(selectedOscillator is OscillatorGroup ? "Reletive frequency (multiply)" : "Frequency", text: $frequency)
                .keyboardType(.decimalPad)
            Button(role: .cancel) {} label: {
                Text("Cancel")
            }
            Button {
                if let freq = Double(frequency), let selectedOscillator {
                    selectedOscillator.frequency = freq
                }
                frequency = ""
            } label: {
                Text("OK")
            }
        }
        .alert("Set Amplitude", isPresented: $showAmplitudeEditor) {
            TextField("Amplitude (in percentage)", text: $amplitude)
                .keyboardType(.decimalPad)
            Button(role: .cancel) {} label: {
                Text("Cancel")
            }
            Button {
                if let amp = Double(amplitude), let selectedOscillator {
                    selectedOscillator.amplitude = amp / 100
                }
                amplitude = ""
            } label: {
                Text("OK")
            }
        }
        .alert("Delete", isPresented: $showDeleteAlert) {
            Button(role: .cancel) {} label: {
                Text("Cancel")
            }
            Button(role: .destructive) {
                if let selectedOscillator {
                    onDelete(selectedOscillator)
                }
            } label: {
                Text("Delete")
            }
        } message: {
            Text("This will delete the oscillator you selected.")
        }
    }
}

struct OscillatorListView_Preview: View {
    @State var oscillator: [Oscillator] = [SineOscillator(amplitude: 1, frequency: 440), SquareOscillator(amplitude: 1, frequency: 440)]
    var body: some View {
        OscillatorListView(oscillators: $oscillator)
    }
}

struct OscillatorListView_Previews: PreviewProvider {
    static var previews: some View {
        OscillatorListView_Preview()
    }
}
