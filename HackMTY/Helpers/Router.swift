//
//  Router.swift
//
//  Created by Fausto Pinto Cabrera on 05/09/24.
//
import Foundation
import SwiftUI

final class Router: ObservableObject {

    public enum Destination: Hashable {
        //On boarding Screens
        case onboarding
        
        //Main app
        case contentView
        case mainScreen
        case cuentasView
        case mapView(expense: Expense)
        
        //Chat screen
        case chatView
        case chatBotView(chatBot: Int)
        
        //userSettings
        case usersettings
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
