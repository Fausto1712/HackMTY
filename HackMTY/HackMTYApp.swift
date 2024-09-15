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
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Expense.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
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
                        case .cuentasView:
                            cuentasView()
                        case .mapView(let expense):
                            ExpenseMapView(expense: expense)
                            
                            //Chat screen
                        case .chatView:
                            chatView()
                        case .chatBotView(let chatBot):
                            chatBotView(chatBot: chatBot)
                            
                            //userSettings
                        case .usersettings:
                            profileView()
                        }
                    }
            }
        }
        .environmentObject(router)
        .modelContainer(sharedModelContainer)
    }
}
