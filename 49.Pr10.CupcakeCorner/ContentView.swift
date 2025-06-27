//
//  ContentView.swift
//  49.Pr10.CupcakeCorner
//
//  Created by Валентин on 27.06.2025.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    ContentView()
}

