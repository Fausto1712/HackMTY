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
    @Published var sex: String { didSet { UserDefaults.standard.set(sex, forKey: "sex") } }
    @Published var address: String { didSet { UserDefaults.standard.set(address, forKey: "address") } }
    @Published var country: String { didSet { UserDefaults.standard.set(country, forKey: "country") } }
    @Published var creditBuro: Bool { didSet { UserDefaults.standard.set(creditBuro, forKey: "creditBuro") } }
    @Published var latitude: Int { didSet { UserDefaults.standard.set(latitude, forKey: "latitude") } }
    @Published var longitude: Int { didSet { UserDefaults.standard.set(longitude, forKey: "longitude") } }
    @Published var phoneNumb: Int { didSet { UserDefaults.standard.set(phoneNumb, forKey: "phoneNumb") } }
    @Published var INE: String { didSet { UserDefaults.standard.set(INE, forKey: "INE") } }
    @Published var Curp: String { didSet { UserDefaults.standard.set(Curp, forKey: "Curp") } }
    @Published var comprobanteDeDomicilio: String { didSet { UserDefaults.standard.set(comprobanteDeDomicilio, forKey: "comprobanteDeDomicilio") } }
    @Published var estadoCivil: String { didSet { UserDefaults.standard.set(estadoCivil, forKey: "estadoCivil") } }
    @Published var ocupation: String { didSet { UserDefaults.standard.set(ocupation, forKey: "ocupation") } }
    @Published var rfc: String { didSet { UserDefaults.standard.set(rfc, forKey: "rfc") } }
    @Published var beneficiarios: [String] { didSet { UserDefaults.standard.set(beneficiarios, forKey: "beneficiarios") } }
    @Published var preferenciaDeComunicacion: String { didSet { UserDefaults.standard.set(preferenciaDeComunicacion, forKey: "preferenciaDeComunicacion") } }
    @Published var birthday: Date { didSet { UserDefaults.standard.set(birthday, forKey: "birthday") } }
    @Published var email: String { didSet { UserDefaults.standard.set(email, forKey: "email") } }
    @Published var picture: String { didSet { UserDefaults.standard.set(picture, forKey: "picture") } }

    init() {
        self.username = UserDefaults.standard.string(forKey: "username") ?? "Beta Tester"
        self.lastName = UserDefaults.standard.string(forKey: "lastname") ?? ""
        self.sex = UserDefaults.standard.string(forKey: "sex") ?? ""
        self.address = UserDefaults.standard.string(forKey: "address") ?? ""
        self.country = UserDefaults.standard.string(forKey: "country") ?? ""
        self.creditBuro = UserDefaults.standard.object(forKey: "creditBuro") as? Bool ?? false
        self.latitude = UserDefaults.standard.integer(forKey: "latitude")
        self.longitude = UserDefaults.standard.integer(forKey: "longitude")
        self.phoneNumb = UserDefaults.standard.integer(forKey: "phoneNumb")
        self.INE = UserDefaults.standard.string(forKey: "INE") ?? ""
        self.Curp = UserDefaults.standard.string(forKey: "Curp") ?? ""
        self.comprobanteDeDomicilio = UserDefaults.standard.string(forKey: "comprobanteDeDomicilio") ?? ""
        self.estadoCivil = UserDefaults.standard.string(forKey: "estadoCivil") ?? ""
        self.ocupation = UserDefaults.standard.string(forKey: "ocupation") ?? ""
        self.rfc = UserDefaults.standard.string(forKey: "rfc") ?? ""
        self.beneficiarios = UserDefaults.standard.stringArray(forKey: "beneficiarios") ?? []
        self.preferenciaDeComunicacion = UserDefaults.standard.string(forKey: "preferenciaDeComunicacion") ?? ""
        self.birthday = UserDefaults.standard.object(forKey: "birthday") as? Date ?? Date()
        self.email = UserDefaults.standard.string(forKey: "email") ?? "No email"
        self.picture = UserDefaults.standard.string(forKey: "picture") ?? "person1"
    }
}
