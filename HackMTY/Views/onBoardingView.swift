//
//  onBoarding.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI
import SwiftData

struct onBoardingView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var expenses: [Expense]
    
    @EnvironmentObject var router: Router
    
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    @StateObject var userModel = UserSettings()
    
    var body: some View {
        VStack{
            Text("On boarding")
            Button {
                isOnboardingCompleted = validInfo()
                router.navigate(to: .contentView)
            } label: {
                Text("Complete Onboarding")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func validInfo() -> Bool {
        userModel.username = "Fausto Pinto"
        userModel.email = "fausto.pintocabrera@gmail.com"
        userModel.picture = "person2"
        if expenses.isEmpty{
            modelContext.insert(Expense(id: 0, date: "14/05/2024", amount: -84, category: "Movimiento Banorte", coordinates: [25.652500562449028, -100.28999620365188], summary: "Compra de un café", title: "Starbuck Tecnologico"))
            modelContext.insert(Expense(id: 1, date: "15/05/2024", amount: -150, category: "Restaurante", coordinates: [25.686614, -100.316113], summary: "Cena en restaurante", title: "La Nacional"))
            modelContext.insert(Expense(id: 2, date: "16/05/2024", amount: 5000, category: "Depósito", coordinates: [25.67507, -100.31847], summary: "Depósito de nómina", title: "BBVA Nómina"))
            modelContext.insert(Expense(id: 3, date: "17/05/2024", amount: -230, category: "Ropa", coordinates: [25.643132, -100.292602], summary: "Compra en tienda de ropa", title: "Zara San Pedro"))
            modelContext.insert(Expense(id: 4, date: "18/05/2024", amount: 1000, category: "Depósito", coordinates: [25.651879, -100.283028], summary: "Ingreso por proyecto freelance", title: "Transferencia Freelance"))
            modelContext.insert(Expense(id: 5, date: "19/05/2024", amount: -450, category: "Electrónica", coordinates: [25.681137, -100.310883], summary: "Compra de audífonos", title: "Best Buy Monterrey"))
            modelContext.insert(Expense(id: 6, date: "20/05/2024", amount: -55, category: "Café", coordinates: [25.65872, -100.30888], summary: "Café en Starbucks", title: "Starbucks Centro"))
            modelContext.insert(Expense(id: 7, date: "21/05/2024", amount: 7500, category: "Depósito", coordinates: [25.657401, -100.30165], summary: "Pago por consultoría", title: "Transferencia Consultoría"))
            modelContext.insert(Expense(id: 8, date: "22/05/2024", amount: -170, category: "Cine", coordinates: [25.681723, -100.292983], summary: "Boleto de cine", title: "Cinépolis Valle Oriente"))
            modelContext.insert(Expense(id: 9, date: "23/05/2024", amount: -680, category: "Supermercado", coordinates: [25.688015, -100.311993], summary: "Compra en supermercado", title: "HEB San Pedro"))
            modelContext.insert(Expense(id: 10, date: "24/05/2024", amount: -200, category: "Taxi", coordinates: [25.666469, -100.307427], summary: "Viaje en Didi", title: "Didi Tecnológico"))
            modelContext.insert(Expense(id: 11, date: "25/05/2024", amount: 300, category: "Depósito", coordinates: [25.651203, -100.290673], summary: "Transferencia de amigo", title: "Transferencia OxxoPay"))
            modelContext.insert(Expense(id: 12, date: "26/05/2024", amount: -320, category: "Comida", coordinates: [25.6539, -100.285617], summary: "Almuerzo en restaurante", title: "Los Arcos"))
            modelContext.insert(Expense(id: 13, date: "27/05/2024", amount: -120, category: "Gasolina", coordinates: [25.661, -100.303], summary: "Carga de gasolina", title: "Gasolinera Pemex"))
            modelContext.insert(Expense(id: 14, date: "28/05/2024", amount: 2500, category: "Depósito", coordinates: [25.679095, -100.32069], summary: "Ingreso adicional", title: "Transferencia Adicional"))
            modelContext.insert(Expense(id: 15, date: "29/05/2024", amount: -90, category: "Suscripción", coordinates: [25.662345, -100.311458], summary: "Suscripción mensual", title: "Spotify Premium"))
        }
        return true
    }
}

#Preview {
    onBoardingView()
}
