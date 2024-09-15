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
                        Label("Main", systemImage: "house.fill")
                    }
                
                GastosView()
                    .tabItem {
                        Label("Cuentas", systemImage: "field.of.view.ultrawide")
                    }
                
                chatView()
                    .tabItem {
                        Label("Chat Bot", systemImage: "bubble")
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
