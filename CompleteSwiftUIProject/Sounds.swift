//
//  Sounds.swift
//  CompleteSwiftUIProject
//
//  Created by Ahmed Kasem on 27/02/2023.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case sound1
        case sound2
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else {return}
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let err {
            print("Error playing sound. \(err.localizedDescription)")
        }
    }
    
}

struct Sounds: View {
        
    var body: some View {
        VStack(spacing: 40) {
            Button("play sound 1") {
                SoundManager.instance.playSound(sound: .sound1)
            }
            Button("play sound 2") {
                SoundManager.instance.playSound(sound: .sound2)
            }
        }
    }
}

struct Sounds_Previews: PreviewProvider {
    static var previews: some View {
        Sounds()
    }
}
