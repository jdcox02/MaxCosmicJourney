//
//  Narrator.swift
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 4/6/24.
//

import Foundation
import AVFAudio

// Narrator class to handle text-to-speech functionality throughout the app.
// This class is implemented as a singleton, meaning there is only one shared instance.
class Narrator {
    static let shared = AVSpeechSynthesizer()
    
    
    // Private initializer to prevent the creation of multiple instances of Narrator.
    // This enforces the singleton pattern by making sure only the shared instance is used.
    private init() {}
    
}
