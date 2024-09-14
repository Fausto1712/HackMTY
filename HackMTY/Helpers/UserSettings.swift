//
//  UserSettings.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 08/05/24.
//

import Foundation

@MainActor
final class UserSettings: ObservableObject {
    @Published var username: String { didSet { UserDefaults.standard.set(username, forKey: "username") } }
    @Published var email: String { didSet { UserDefaults.standard.set(email, forKey: "email") } }
    @Published var picture: String { didSet { UserDefaults.standard.set(picture, forKey: "picture") } }
    
    init() {
        self.username = UserDefaults.standard.string(forKey: "username") ?? "Beta Tester"
        self.email = UserDefaults.standard.string(forKey: "email") ?? "No email"
        self.picture = UserDefaults.standard.string(forKey: "picture") ?? "person1"
    }
}
