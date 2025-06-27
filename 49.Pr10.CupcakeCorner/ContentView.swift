//
//  ContentView.swift
//  49.Pr10.CupcakeCorner
//
//  Created by Валентин on 27.06.2025.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("Play Haptic") {
            complexSuccess()
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        //параметр интенсивного удара
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        
        //параметр резкого удара
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        
        //.hapticTransient - одноразовое нажатие, массив параметров - созданные только что, время = 0
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
 }

#Preview {
    ContentView()
}

