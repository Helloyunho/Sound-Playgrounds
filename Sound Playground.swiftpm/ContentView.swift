import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        MainView()
            .onAppear {
                try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers, .allowBluetooth, .allowBluetoothA2DP, .allowAirPlay])
            }
    }
}
