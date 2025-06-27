//
//  ContentView.swift
//  49.Pr10.CupcakeCorner
//
//  Created by Валентин on 27.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    var body: some View {
        Button("Количество нажатий: \(counter)") {
            counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
    }
 }

#Preview {
    ContentView()
}

