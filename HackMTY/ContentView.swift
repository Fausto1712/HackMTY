//
//  ContentView.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    @StateObject var userModel = UserSettings()

    var body: some View {
        if isOnboardingCompleted {
            TabView {
                mainView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                chatView()
                    .tabItem {
                        Label("Next Up", systemImage: "party.popper")
                    }
            }
            .navigationBarBackButtonHidden(true)
        } else {
            onBoardingView()
        }
    }
}

#Preview {
    ContentView()
}
