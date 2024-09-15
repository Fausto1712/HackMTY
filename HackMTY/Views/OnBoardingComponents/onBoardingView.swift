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
            modelContext.insert(Expense(id: 16, date: "18/05/2024", amount: -75, category: "Entretenimiento", coordinates: [25.686345, -100.317543], summary: "Boletos de cine", title: "Cinépolis"))
            modelContext.insert(Expense(id: 17, date: "20/05/2024", amount: -300, category: "Electronica", coordinates: [25.686123, -100.314321], summary: "Compra de audífonos", title: "Best Buy"))
            modelContext.insert(Expense(id: 18, date: "21/05/2024", amount: -50, category: "Transporte", coordinates: [25.687891, -100.318765], summary: "Viaje en Uber", title: "Uber"))
            modelContext.insert(Expense(id: 19, date: "23/05/2024", amount: -100, category: "Supermercado", coordinates: [25.689123, -100.312987], summary: "Compras de despensa", title: "Walmart"))
            modelContext.insert(Expense(id: 20, date: "25/05/2024", amount: -200, category: "Ropa y calzado", coordinates: [25.688765, -100.319876], summary: "Compra de zapatos", title: "Nike Store"))
            modelContext.insert(Expense(id: 21, date: "27/05/2024", amount: -60, category: "Servicios", coordinates: [25.689432, -100.314876], summary: "Pago de suscripción de música", title: "Spotify"))
            modelContext.insert(Expense(id: 22, date: "28/05/2024", amount: -180, category: "Entretenimiento", coordinates: [25.686512, -100.310987], summary: "Concierto en vivo", title: "Arena Monterrey"))
            modelContext.insert(Expense(id: 23, date: "30/05/2024", amount: -90, category: "Restaurante", coordinates: [25.685432, -100.316654], summary: "Almuerzo con amigos", title: "El Rey del Cabrito"))
            modelContext.insert(Expense(id: 24, date: "01/06/2024", amount: -500, category: "Electronica", coordinates: [25.684321, -100.320876], summary: "Compra de laptop", title: "Apple Store"))
            modelContext.insert(Expense(id: 25, date: "03/06/2024", amount: -40, category: "Transporte", coordinates: [25.686421, -100.312345], summary: "Viaje en taxi", title: "Taxi local"))
            modelContext.insert(Expense(id: 26, date: "05/06/2024", amount: -150, category: "Supermercado", coordinates: [25.687643, -100.311234], summary: "Compra de comestibles", title: "Soriana"))
            modelContext.insert(Expense(id: 27, date: "07/06/2024", amount: -220, category: "Ropa y calzado", coordinates: [25.686234, -100.313987], summary: "Compra de abrigo", title: "Zara"))
            modelContext.insert(Expense(id: 28, date: "10/06/2024", amount: -100, category: "Servicios", coordinates: [25.688987, -100.319432], summary: "Pago de agua", title: "Agua y Drenaje"))
            modelContext.insert(Expense(id: 29, date: "12/06/2024", amount: -50, category: "Entretenimiento", coordinates: [25.684987, -100.316789], summary: "Alquiler de película", title: "Google Play Movies"))
            modelContext.insert(Expense(id: 30, date: "15/06/2024", amount: -80, category: "Restaurante", coordinates: [25.689876, -100.320123], summary: "Cena rápida", title: "McDonald's"))
            modelContext.insert(Expense(id: 31, date: "17/06/2024", amount: -200, category: "Electronica", coordinates: [25.687654, -100.314345], summary: "Compra de teclado", title: "Office Depot"))
            modelContext.insert(Expense(id: 32, date: "19/06/2024", amount: -70, category: "Transporte", coordinates: [25.685321, -100.317876], summary: "Gasolina para coche", title: "Oxxo Gas"))
            modelContext.insert(Expense(id: 33, date: "21/06/2024", amount: -120, category: "Supermercado", coordinates: [25.683456, -100.310654], summary: "Compra de frutas y verduras", title: "H-E-B"))
            modelContext.insert(Expense(id: 34, date: "23/06/2024", amount: -180, category: "Ropa y calzado", coordinates: [25.684765, -100.315876], summary: "Compra de jeans", title: "Levi's"))
            modelContext.insert(Expense(id: 35, date: "25/06/2024", amount: -110, category: "Servicios", coordinates: [25.686876, -100.312987], summary: "Pago de luz", title: "CFE"))
            modelContext.insert(Expense(id: 36, date: "27/06/2024", amount: -50, category: "Entretenimiento", coordinates: [25.686765, -100.315432], summary: "Suscripción de Netflix", title: "Netflix"))
            modelContext.insert(Expense(id: 37, date: "29/06/2024", amount: -350, category: "Electronica", coordinates: [25.685876, -100.312654], summary: "Compra de monitor", title: "Samsung Store"))
            modelContext.insert(Expense(id: 38, date: "01/07/2024", amount: -25, category: "Transporte", coordinates: [25.683432, -100.317654], summary: "Viaje en camión", title: "Ruta 39"))
            modelContext.insert(Expense(id: 39, date: "03/07/2024", amount: -70, category: "Supermercado", coordinates: [25.688432, -100.312987], summary: "Compra de productos de limpieza", title: "La Comer"))
            modelContext.insert(Expense(id: 40, date: "05/07/2024", amount: -250, category: "Ropa y calzado", coordinates: [25.687654, -100.314321], summary: "Compra de chaqueta", title: "Bershka"))
            modelContext.insert(Expense(id: 41, date: "07/07/2024", amount: -130, category: "Servicios", coordinates: [25.689321, -100.311987], summary: "Pago de internet", title: "Telmex"))
            modelContext.insert(Expense(id: 42, date: "09/07/2024", amount: -45, category: "Entretenimiento", coordinates: [25.686432, -100.313876], summary: "Compra de videojuego móvil", title: "App Store"))
            modelContext.insert(Expense(id: 43, date: "11/07/2024", amount: -90, category: "Restaurante", coordinates: [25.689654, -100.320432], summary: "Cena en pizzería", title: "Papa John's"))
            modelContext.insert(Expense(id: 44, date: "13/07/2024", amount: -400, category: "Electronica", coordinates: [25.688432, -100.315876], summary: "Compra de tablet", title: "iShop"))
            modelContext.insert(Expense(id: 45, date: "15/07/2024", amount: -100, category: "Transporte", coordinates: [25.687432, -100.318765], summary: "Recarga de gasolina", title: "Pemex"))
            modelContext.insert(Expense(id: 46, date: "17/07/2024", amount: -60, category: "Supermercado", coordinates: [25.685654, -100.312543], summary: "Compra de lácteos", title: "Soriana"))
            modelContext.insert(Expense(id: 47, date: "19/07/2024", amount: -300, category: "Ropa y calzado", coordinates: [25.683987, -100.314321], summary: "Compra de vestido", title: "H&M"))
            modelContext.insert(Expense(id: 48, date: "21/07/2024", amount: -80, category: "Servicios", coordinates: [25.686765, -100.310987], summary: "Pago de suscripción de TV", title: "Dish"))
            modelContext.insert(Expense(id: 49, date: "23/07/2024", amount: -120, category: "Entretenimiento", coordinates: [25.688432, -100.316543], summary: "Evento de teatro", title: "Teatro Monterrey"))
            modelContext.insert(Expense(id: 50, date: "25/07/2024", amount: -60, category: "Restaurante", coordinates: [25.685876, -100.319876], summary: "Comida rápida", title: "Taco Bell"))
        }
        return true
    }
}

#Preview {
    onBoardingView()
}

