import AVFoundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
            .onAppear {
                try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers, .allowBluetooth, .allowBluetoothA2DP, .allowAirPlay])
                try? AVAudioSession.sharedInstance().setActive(true)
            }
    }
}
