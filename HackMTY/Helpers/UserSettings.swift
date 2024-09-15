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
    @Published var lastName: String { didSet { UserDefaults.standard.set(lastName, forKey: "lastname") } }
    @Published var picture: String { didSet { UserDefaults.standard.set(picture, forKey: "picture") } }
    @Published var sex: String { didSet { UserDefaults.standard.set(sex, forKey: "sex") } }
    @Published var country: String { didSet { UserDefaults.standard.set(country, forKey: "country") } }
    @Published var creditBuro: Bool { didSet { UserDefaults.standard.set(creditBuro, forKey: "creditBuro") } }
    @Published var estadoCivil: String { didSet { UserDefaults.standard.set(estadoCivil, forKey: "estadoCivil") } }
    @Published var ocupation: String { didSet { UserDefaults.standard.set(ocupation, forKey: "ocupation") } }
    @Published var birthday: String { didSet { UserDefaults.standard.set(birthday, forKey: "birthday") } }
    @Published var sueldo: String { didSet { UserDefaults.standard.set(sueldo, forKey: "sueldo") } }

    init() {
        self.username = UserDefaults.standard.string(forKey: "username") ?? "Beta Tester"
        self.lastName = UserDefaults.standard.string(forKey: "lastname") ?? ""
        self.picture = UserDefaults.standard.string(forKey: "picture") ?? "persona5"
        self.sex = UserDefaults.standard.string(forKey: "sex") ?? ""
        self.country = UserDefaults.standard.string(forKey: "country") ?? ""
        self.creditBuro = UserDefaults.standard.object(forKey: "creditBuro") as? Bool ?? false
        self.estadoCivil = UserDefaults.standard.string(forKey: "estadoCivil") ?? ""
        self.ocupation = UserDefaults.standard.string(forKey: "ocupation") ?? ""
        self.birthday = UserDefaults.standard.string(forKey: "birthday") ?? ""
        self.sueldo = UserDefaults.standard.string(forKey: "sueldo") ?? "1000"
    }
}
