//
//  WelcomeView.swift
//  
//
//  Created by Helloyunho on 2023/04/13.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Sound Playgrounds Usage")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.vertical, 80)
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 40)
                            .padding()
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Add Sounds")
                                .fontWeight(.bold)
                            Text("Touch the plus button to create an oscillator.")
                                .foregroundColor(.gray)
                        }
                    }
                    HStack {
                        Image(systemName: "play.square.stack.fill")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 40)
                            .padding()
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Group Oscillators")
                                .fontWeight(.bold)
                            Text("Make a group of oscillators and create your own unique sound.")
                                .foregroundColor(.gray)
                        }
                    }
                    HStack {
                        Image(systemName: "square.stack.3d.up.fill")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 40)
                            .padding()
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Multi Track")
                                .fontWeight(.bold)
                            Text("The main group works like a multi track. Add more oscillators, play more at once.")
                                .foregroundColor(.gray)
                        }
                    }
                    HStack {
                        Image(systemName: "hand.draw.fill")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 40)
                            .padding()
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Customization")
                                .fontWeight(.bold)
                            Text("Change the frequency and amplitude by moving your finger on Oscillator.")
                                .foregroundColor(.gray)
                        }
                    }
                    HStack {
                        Image(systemName: "hand.tap.fill")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 40)
                            .padding()
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Precise Control")
                                .fontWeight(.bold)
                            Text("If you want more precise control, you can press and hold to type frequency and amplitude manually.")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            Spacer()
            Button {
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "notFirstRun")
                dismiss()
            } label: {
                HStack {
                    Spacer()
                    Text("Start")
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                .padding()
            }
        }
        .interactiveDismissDisabled()
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
