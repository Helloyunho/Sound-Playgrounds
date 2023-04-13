//
//  MainAudio.swift
//
//
//  Created by Helloyunho on 2023/04/08.
//

import AVFoundation
import Foundation

// Based on https://github.com/GrantJEmerson/SwiftSynth/blob/master/Swift%20Synth/Audio/Synth.swift and modified to support multi track
@MainActor
class MainAudio: ObservableObject {
    public var volume: Float {
        set {
            audioEngine.mainMixerNode.outputVolume = newValue
        }
        get {
            audioEngine.mainMixerNode.outputVolume
        }
    }
    @Published public var isPlaying = false
    @Published public var oscillators = [Oscillator]()

    private var audioEngine: AVAudioEngine
    
//    private var time: Double = 0
    private let sampleRate: Double
    private let deltaTime: Double
    private let format: AVAudioFormat
    
    private var nodes = [UUID: AVAudioNode]()
    
    // MARK: Init
    
    init() {
        audioEngine = AVAudioEngine()
        
        let mainMixer = audioEngine.mainMixerNode
        let outputNode = audioEngine.outputNode
        
        format = outputNode.inputFormat(forBus: 0)
        
        sampleRate = format.sampleRate
        deltaTime = 1 / sampleRate

        audioEngine.connect(mainMixer, to: outputNode, format: nil)
        mainMixer.outputVolume = 1
    }
    
    func add(oscillator osc: Oscillator) {
        let id = osc.id
        var time: Double = 0
        
        let audioNode = AVAudioSourceNode { _, _, frameCount, audioBufferList in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)

            for frame in 0 ..< Int(frameCount) {
                let sampleVal = osc.perform(time)
                time += self.deltaTime

                for buffer in ablPointer {
                    let buf: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                    buf[frame] = Float(sampleVal)
                }
            }
            
            return noErr
        }
        
        let inputFormat = AVAudioFormat(commonFormat: format.commonFormat,
                                        sampleRate: format.sampleRate,
                                        channels: 1,
                                        interleaved: format.isInterleaved)
        
        audioEngine.attach(audioNode)
        audioEngine.connect(audioNode,
                            to: audioEngine.mainMixerNode,
                            format: nil)
        
        nodes[id] = audioNode
        oscillators.append(osc)
    
        volume = 1 / Float(oscillators.count)
    }
    
    func remove(oscillator osc: Oscillator) {
        let id = osc.id
        guard let node = nodes[id] else {
            return
        }
        
        audioEngine.disconnectNodeOutput(node)
        audioEngine.detach(node)
        
        nodes.removeValue(forKey: id)
        oscillators.remove(element: osc)
        
        volume = 1 / Float(oscillators.count)
    }
    
    func pause() {
        self.audioEngine.pause()
        self.isPlaying = false
    }
    
    func play() {
        do {
            try audioEngine.start()
            self.isPlaying = true
        } catch {
            print("Could not start engine: \(error.localizedDescription)")
        }
    }
}
