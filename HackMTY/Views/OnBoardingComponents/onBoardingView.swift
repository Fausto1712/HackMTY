import SwiftUI
import SwiftData

// Custom NavBar View
struct CustomNavBarView: View {
    @Binding var currentStep: Int  // Paso actual que controla la navegación

    var body: some View {
        VStack {
            // Custom NavBar
            HStack {
                // Botón de retroceso solo si no estamos en el primer paso
                if currentStep > 1 {
                    Button(action: {
                        if currentStep > 1 {
                            currentStep -= 1  // Resta uno al contador de pasos
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.red)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                Spacer()

                // Imagen y Texto en el centro
                HStack(spacing: 8) {
                    Image(uiImage: UIImage(named: "B")!) // Asegúrate de agregar la imagen en tus Assets
                        .resizable()
                        .frame(width: 28, height: 18)
                    Text("BANORTE")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(.red)
                }
                .padding(.trailing, 16)

                // Placeholder para el espaciado del lado derecho
                Spacer(minLength: 44)
            }
            .padding(.horizontal)
            .frame(height: 44)
        }
    }
}

struct onBoardingView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var expenses: [Expense]
    
    @EnvironmentObject var router: Router
    
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    @StateObject var userModel = UserSettings()
    @State private var currentStep: Int = 1  // Controla el flujo de pantallas

    var body: some View {
        NavigationStack {
            VStack {
                // Custom NavBar
                if currentStep > 1 {
                    CustomNavBarView(currentStep: $currentStep)
                }

                Spacer()

                // Control del flujo de pantallas
                switch currentStep {
                case 1:
                    BienvenidaView(currentStep: $currentStep)  // Paso 1
                case 2:
                    TelefonoView(currentStep: $currentStep)  // Paso 2
                case 3:
                    TelefonoPinView(currentStep: $currentStep)  // Paso 3
                case 4:
                    PaisResidenciaView(currentStep: $currentStep)  // Paso 4
                case 5:
                    DatosPersonalesView(currentStep: $currentStep)  // Paso 5
                case 6:
                    SubirDocumentoView(currentStep: $currentStep)  // Paso 6
                case 7:
                    EscaneoDocumentoView(currentStep: $currentStep)  // Paso 7
                case 8:
                    UnaPreguntaView(currentStep: $currentStep)  // Paso 8
                case 9:
                    TarjetaIdealView(currentStep: $currentStep)  // Paso 9
                case 10:
                    SeguridadView(currentStep: $currentStep)  // Paso 10
                default:
                    BienvenidaDosView(currentStep: $currentStep )  // Default case
                }

                Spacer()

                // Botón Siguiente para finalizar el flujo en la última pantalla
                if currentStep == 10 {
                    Button(action: {
                        // Acción para finalizar el onboarding
                        isOnboardingCompleted = validInfo()
                        router.navigate(to: .contentView)
                    }) {
                        Text("Finalizar")
                            .font(.figtree(size: 17, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(24)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    
    func validInfo() -> Bool {
        userModel.username = "Fausto"
        userModel.picture = "person1"
        userModel.lastName = "Pinto Cabrera"
        userModel.sex = "Male"
        userModel.sueldo = "12000"
        userModel.country = "Mexico"
        userModel.creditBuro = false
        userModel.estadoCivil = "Soltero"
        userModel.ocupation = "Practicante"
        userModel.birthday = "17/12/2001"
        
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

