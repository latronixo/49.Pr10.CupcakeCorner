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
        
        //Цикл, в котором создаются и добавляются в массив события виброотклика с интенсивностью и резкостью вибрации от 0 до 1 c задержкой времени от 0,1 до 1 сек
        for i in stride(from: 0, to: 1, by: 0.1) {
            //параметр интенсивного удара
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            
            //параметр резкого удара
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            
            //.hapticTransient - одноразовое нажатие, массив параметров - созданные только что, время = 0
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        //Цикл, в котором создаются и добавляются в массив события виброотклика с интенсивностью и резкостью вибрации от 1 до 0 c задержкой времени от 1,1 до 2 сек
        for i in stride(from: 0, to: 1, by: 0.1) {
            //параметр интенсивного удара
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            
            //параметр резкого удара
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            
            //.hapticTransient - одноразовое нажатие, массив параметров - созданные только что, время = 0
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
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

