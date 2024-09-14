//
//  HackMTYApp.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI
import SwiftData

@main
struct HackMTYApp: App {
    @ObservedObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                ContentView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                            //On boarding Screens
                        case .onboarding:
                            onBoardingView()
                            
                            //Main app
                        case .contentView:
                            ContentView()
                        case .mainScreen:
                            mainView()
                            
                            //Chat screen
                        case .chatBot:
                            chatView()
                            
                            //userSettings
                        case .usersettings:
                            profileView()
                        }
                    }
            }
        }
        .environmentObject(router)
    }
}
