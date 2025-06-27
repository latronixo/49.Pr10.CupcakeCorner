//
//  ContentView.swift
//  49.Pr10.CupcakeCorner
//
//  Created by Валентин on 27.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(username.isEmpty || email.isEmpty)
        }
    }
}

#Preview {
    ContentView()
}

