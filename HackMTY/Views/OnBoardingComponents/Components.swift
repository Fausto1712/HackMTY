import SwiftUI

// Views 2 - 3
struct TelefonoView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    @State private var phoneNumber: String = ""
    @State private var isButtonDisabled: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header con título
            (Text("Tu ")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
            + Text("Teléfono")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.red)
            )
            
            // Subtítulo
            Text("Te enviaremos SMS importantes por este medio.")
                .font(.figtree(size: 17, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, -16)
            
            // Campo de teléfono
            VStack(alignment: .leading, spacing: 8) {
                Text("Celular")
                    .font(.figtree(size: 15, weight: .semiBold))
                    .foregroundColor(.gray)
                
                TextField("+52 000 000 0000", text: $phoneNumber)
                    .keyboardType(.numberPad)  // Teclado numérico
                    .font(.figtree(size: 17, weight: .medium))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .onChange(of: phoneNumber) { newValue in
                        validatePhoneNumber(newValue)
                    }
            }
            
            Spacer()
            
            // Botón Siguiente
            Button(action: {
                // Acción para el botón
                currentStep += 1
                print("Número de teléfono válido: \(phoneNumber)")
            }) {
                Text("Siguiente")
                    .font(.figtree(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isButtonDisabled ? Color.gray : Color.red)  // El botón es gris si está deshabilitado
                    .cornerRadius(24)
            }
            .disabled(isButtonDisabled)  // Deshabilita el botón si no hay 13 dígitos
            .padding(.bottom)
        }
        .padding()
    }

    // Validación del número de teléfono
    private func validatePhoneNumber(_ value: String) {
        // Mantener solo números en el texto
        phoneNumber = value.filter { "0123456789".contains($0) }
        
        // Deshabilitar el botón si el número de caracteres no es 13
        if phoneNumber.count == 12 {
            isButtonDisabled = false
        } else {
            isButtonDisabled = true
        }
    }
}


struct TelefonoPinView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    @State private var pinCode: [String] = Array(repeating: "", count: 5)  // Un array para guardar cada dígito del PIN
    @State private var isButtonDisabled: Bool = true  // Deshabilita el botón hasta que se ingrese el PIN completo
    @FocusState private var focusedField: Int?  // Para controlar el foco de los campos de texto
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header con título
            (Text("Tu ")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
            + Text("Teléfono")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.red)
            )
            
            // Subtítulo
            Text("Te enviaremos SMS importantes por este medio.")
                .font(.figtree(size: 17, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, -16)
            
            HStack(spacing: 10) {
                ForEach(0..<5) { index in
                    TextField("", text: $pinCode[index])
                        .frame(width: 60, height: 60)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .font(.figtree(size: 24, weight: .medium))
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .focused($focusedField, equals: index)  // Controla el foco
                        .onChange(of: pinCode[index]) { newValue in
                            // Limitar la entrada a un solo dígito
                            if newValue.count > 1 {
                                pinCode[index] = String(newValue.prefix(1))
                            }
                            
                            // Si se ingresa un dígito, pasar al siguiente campo
                            if newValue.count == 1 {
                                if index < 4 {
                                    focusedField = index + 1
                                } else {
                                    focusedField = nil  // Desenfocar si está en el último campo
                                }
                            }
                            
                            // Si el campo se vacía, moverse al campo anterior
                            if newValue.isEmpty, index > 0 {
                                focusedField = index - 1
                            }
                            
                            validatePinCode()
                        }
                }
            }
            .padding(.top, -4)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
            // Botón Siguiente
            Button(action: {
                // Acción para el botón cuando el PIN está completo
                currentStep += 1
                print("Código PIN ingresado: \(pinCode.joined())")
            }) {
                Text("Siguiente")
                    .font(.figtree(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isButtonDisabled ? Color.gray : Color.red)  // El botón es gris si está deshabilitado
                    .cornerRadius(24)
            }
            .disabled(isButtonDisabled)  // Deshabilita el botón si el PIN no está completo
            .padding(.bottom)
        }
        .padding()
        .onAppear {
            // Enfocar el primer campo cuando aparece la vista
            focusedField = 0
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Validación del código PIN
    private func validatePinCode() {
        // Comprobar si todos los campos del array tienen un carácter (un dígito)
        if pinCode.allSatisfy({ $0.count == 1 }) {
            isButtonDisabled = false
        } else {
            isButtonDisabled = true
        }
    }
}


struct PaisResidenciaView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    @State private var searchText: String = ""  // Campo de búsqueda
    @State private var selectedCountry: String? = nil  // País seleccionado
    @State private var isButtonDisabled: Bool = true  // Botón deshabilitado hasta que se seleccione un país
    
    let countries = [
        ("México", "🇲🇽"),
        ("Argentina", "🇦🇷"),
        ("Belice", "🇧🇿"),
        ("Brasil", "🇧🇷"),
        ("Canadá", "🇨🇦"),
        ("Chile", "🇨🇱"),
        ("Estados Unidos", "🇺🇸")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header con título
            (Text("País de ")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
             + Text("Residencia")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.red)
            )
            
            // Subtítulo
            Text("¿De qué nación te estás uniendo?")
                .font(.figtree(size: 17, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, -16)
            
            // Campo de búsqueda personalizado
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Busca tu país", text: $searchText)
                        .font(.figtree(size: 16, weight: .regular))
                    
                    Button(action: {
                        // Acción del micrófono (por ejemplo, búsqueda por voz)
                    }) {
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding(8)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            }
            .padding(.top, 4)
            
            // Lista de países
            VStack(spacing: 0) {
                ForEach(filteredCountries(), id: \.0) { country in
                    CountryRow(countryName: country.0, flagEmoji: country.1, isSelected: selectedCountry == country.0)
                        .onTapGesture {
                            selectedCountry = country.0
                            isButtonDisabled = false  // Habilita el botón cuando se selecciona un país
                        }
                
                    Divider()  // Añadimos un separador entre los elementos
                }
            }
            
            Spacer()
            VStack{
                // Pie de página con texto
                Text("Al completar el proceso estarás aceptando nuestra Política de Privacidad y nuestros Términos y Condiciones")
                    .font(.figtree(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)  // Permitir que crezca verticalmente si es necesario
                    .padding(.horizontal)
                    
                
                // Botón Siguiente
                Button(action: {
                    // Acción para el botón "Siguiente"
                    currentStep += 1
                    print("País seleccionado: \(selectedCountry ?? "")")
                }) {
                    Text("Siguiente")
                        .font(.figtree(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isButtonDisabled ? Color.gray : Color.red)
                        .cornerRadius(24)
                }
                .disabled(isButtonDisabled)  // Deshabilita el botón si no se selecciona un país
                .padding(.bottom)
                .padding(.top, 8)
            }
        }
            
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Función para filtrar países en la búsqueda
    private func filteredCountries() -> [(String, String)] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.0.lowercased().contains(searchText.lowercased()) }
        }
    }
}

// Componente personalizado para cada fila de país
struct CountryRow: View {
    let countryName: String
    let flagEmoji: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Text(flagEmoji)
                .font(.largeTitle)
            
            Text(countryName)
                .font(.figtree(size: 17, weight: isSelected ? .semiBold : .regular))
                .foregroundColor(isSelected ? .arrowRed : .black)
            
            Spacer()
            
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.arrowRed)
            }
        }
        .padding(.vertical, 12)
        .background(isSelected ? Color(UIColor.systemGray5) : Color.white)  // Preventing blue highlight
        .contentShape(Rectangle())  // Make entire row tappable without affecting the text
    }
}

struct DatosPersonalesView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    @State private var nombre: String = ""
    @State private var apellido: String = ""
    @State private var diaNacimiento: Int = 1  // Día de nacimiento por defecto
    @State private var mesNacimiento: Int = 1  // Mes de nacimiento por defecto
    @State private var añoNacimiento: Int = 2000  // Año de nacimiento por defecto
    @State private var sexo: String = "Masculino"  // Valor por defecto
    @State private var estadoCivil: String = "Soltero(a)"  // Valor por defecto
    @State private var ocupacion: String = ""
    
    @State private var showDiaPicker = false
    @State private var showMesPicker = false
    @State private var showAñoPicker = false
    @State private var showSexoPicker = false
    @State private var showEstadoCivilPicker = false
    
    let sexos = ["Masculino", "Femenino", "Otro"]
    let estadosCiviles = ["Soltero(a)", "Casado(a)", "Divorciado(a)", "Viudo(a)"]
    
    // Obtiene los nombres de los meses en español
    let months = Calendar.current.monthSymbols.map { $0.capitalized(with: Locale(identifier: "es_MX")) }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header con título
                    (Text("Datos ")
                        .font(.custom("Poppins-Bold", size: 28))
                        .foregroundColor(.black)
                    + Text("Personales")
                        .font(.custom("Poppins-Bold", size: 28))
                        .foregroundColor(.red)
                    )
                    
                    // Subtítulo
                    Text("Escríbelos como aparecen en tu documento de identidad.")
                        .font(.figtree(size: 17, weight: .regular))
                        .foregroundColor(.gray)
                        .padding(.top, -16)
                    
                    // Nombre
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nombre")
                            .font(.figtree(size: 15, weight: .semiBold))
                            .foregroundColor(.gray)
                        
                        TextField("Ingresa tu nombre", text: $nombre)
                            .font(.figtree(size: 17, weight: .regular))
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                    
                    // Apellido
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Apellido")
                            .font(.figtree(size: 15, weight: .semiBold))
                            .foregroundColor(.gray)
                        
                        TextField("Ingresa tu apellido", text: $apellido)
                            .font(.figtree(size: 17, weight: .regular))
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                    
                    // Sección de Fecha de Nacimiento con Día, Mes, y Año separados
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Fecha de Nacimiento")
                            .font(.figtree(size: 15, weight: .semiBold))
                            .foregroundColor(.gray)
                        
                        HStack {
                            // Botón para seleccionar el Día
                            Button(action: {
                                showDiaPicker.toggle()
                            }) {
                                HStack {
                                    Text("\(diaNacimiento)")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                            }

                            
                            // Botón para seleccionar el Año
                            Button(action: {
                                showAñoPicker.toggle()
                            }) {
                                HStack {
                                    Text("\(añoNacimiento)")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                            }
                            .padding(.leading, 4)  // Añadir un pequeño espacio extra entre Mes y Año
                        }
                        HStack{
                            
                            // Botón para seleccionar el Mes (Español)
                            Button(action: {
                                showMesPicker.toggle()
                            }) {
                                HStack {
                                    Text("\(months[mesNacimiento - 1])")  // Mes en español
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                            }
                        }
                    }
                    
                    // Sexo y Estado Civil en una sola fila
                    HStack(spacing: 16) {
                        // Campo personalizado de Sexo
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Sexo")
                                .font(.figtree(size: 15, weight: .semiBold))
                                .foregroundColor(.gray)
                            
                            Button(action: {
                                showSexoPicker.toggle()
                            }) {
                                HStack {
                                    Text(sexo)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                            }
                        }
                        
                        // Campo personalizado de Estado Civil
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Estado Civil")
                                .font(.figtree(size: 15, weight: .semiBold))
                                .foregroundColor(.gray)
                            
                            Button(action: {
                                showEstadoCivilPicker.toggle()
                            }) {
                                HStack {
                                    Text(estadoCivil)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                            }
                        }
                    }
                    
                    // Ocupación
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ocupación")
                            .font(.figtree(size: 15, weight: .semiBold))
                            .foregroundColor(.gray)
                        
                        TextField("Ingresa tu ocupación", text: $ocupacion)
                            .font(.figtree(size: 17, weight: .regular))
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                    
                    // Botón Siguiente
                    Button(action: {
                        // Acción del botón Siguiente
                        currentStep += 1
                        print("Datos personales completados.")
                    }) {
                        Text("Siguiente")
                            .font(.figtree(size: 17, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(24)
                    }
                    .padding(.top, 24)
                }
                .padding()
            }
            
            // Picker que aparece desde abajo para Día, Mes y Año
            if showDiaPicker || showMesPicker || showAñoPicker || showSexoPicker || showEstadoCivilPicker {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        
                        VStack {
                            HStack {
                                Spacer()
                                Button("Listo") {
                                    showDiaPicker = false
                                    showMesPicker = false
                                    showAñoPicker = false
                                    showSexoPicker = false
                                    showEstadoCivilPicker = false
                                }
                                .padding()
                            }
                            
                            // Picker según el campo seleccionado
                            if showDiaPicker {
                                Picker("Día", selection: $diaNacimiento) {
                                    ForEach(1...31, id: \.self) {
                                        Text("\($0)").tag($0)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .labelsHidden()
                            }
                            
                            if showMesPicker {
                                Picker("Mes", selection: $mesNacimiento) {
                                    ForEach(1...12, id: \.self) {
                                        Text(months[$0 - 1]).tag($0)  // Meses en español
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .labelsHidden()
                            }
                            
                            if showAñoPicker {
                                Picker("Año", selection: $añoNacimiento) {
                                    ForEach(1900...2023, id: \.self) {
                                        Text("\($0)").tag($0)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .labelsHidden()
                            }
                            
                            if showSexoPicker {
                                Picker("Sexo", selection: $sexo) {
                                    ForEach(sexos, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .labelsHidden()
                            }
                            
                            if showEstadoCivilPicker {
                                Picker("Estado Civil", selection: $estadoCivil) {
                                    ForEach(estadosCiviles, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .labelsHidden()
                            }
                        }
                        .frame(height: 300)
                        .background(Color.white)
                        .cornerRadius(20)
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                    }
                    .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SubirDocumentoView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Título
            (Text("Sube tu ")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
            + Text("Documento")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.red)
            )
            
            // Subtítulo
            Text("¡Verificaremos que eres tú en segundos!")
                .font(.figtree(size: 17, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, -16)  // Espacio entre subtítulo y botones
            
            
            HStack{
                Circle()
                    .fill(Color(UIColor.systemGray5))
                    .shadow(radius: 2, x: 0, y: 1)
                    .frame(width: 40, height: 40)
                    .overlay{
                        Image(systemName: "person.text.rectangle")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundColor(.gray)
                    }
                HStack{
                    VStack(alignment: .leading) {
                        Text("Documento de Identidad")
                            .font(.figtree(size: 17, weight: .semiBold))
                            .foregroundColor(.arrowRed)
                        Text("Escanea tu documento de identidad")
                            .font(.figtree(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 16)
            .onTapGesture {
                currentStep += 1
            }
            
            
            HStack{
                Circle()
                
                    .fill(Color(UIColor.systemGray5))
                    .shadow(radius: 2, x: 0, y: 1)
                    .frame(width: 40, height: 40)
                    .overlay{
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundColor(.gray)
                    }
                
                HStack{
                    VStack(alignment: .leading) {
                        Text("Pasaporte")
                            .font(.figtree(size: 17, weight: .semiBold))
                            .foregroundColor(.arrowRed)
                        Text("Escanea tu pasaporte")
                            .font(.figtree(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 16)

    Spacer()
            
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EscaneoDocumentoView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    @State private var isScanComplete: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Título
            (Text("¡")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
            + Text("Escanea")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.red)
            + Text("!")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
            )
            
            // Subtítulo
            Text("¡Verificaremos que eres tú en segundos!")
                .font(.figtree(size: 17, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, -16)
            
            // Verificación de escaneo completado
            if isScanComplete {
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)
                    
                    Text("¡Listo!")
                        .font(.figtree(size: 16, weight: .regular))
                        .foregroundColor(.black)
                        .padding(.top, 4)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            } else {
                // Botón para escanear
                Button(action: {
                    // Acción para iniciar el escaneo
                    isScanComplete.toggle()
                }) {
                    VStack {
                        Image(systemName: "doc.text.viewfinder")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                        
                        Text("Presiona para escanear")
                            .font(.figtree(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                            .padding(.top, 4)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
            }
            
            Spacer()
            
            // Botón Siguiente
            Button(action: {
                // Acción cuando el escaneo está completo
                currentStep += 1
                print("Escaneo completado. Continuar.")
            }) {
                Text("Siguiente")
                    .font(.figtree(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isScanComplete ? Color.red : Color(UIColor.systemGray5))
                    .cornerRadius(24)
            }
            .disabled(!isScanComplete)  // Desactiva el botón hasta que el escaneo esté completo
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UnaPreguntaView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Título
            (Text("Una ")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
            + Text("Pregunta...")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.red)
            )
            
            // Subtítulo
            Text("¿Ya has manejado cuentas \nbancarias con anterioridad?")
                .font(.figtree(size: 17, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, -16)  // Espacio entre subtítulo y botones
            
            
            HStack{
                Circle()
                    .fill(Color(.arrowRed))
                    .shadow(radius: 2, x: 0, y: 1)
                    .frame(width: 40, height: 40)
                    .overlay{
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundColor(.white)
                            .bold()
                    }
                HStack{
                    VStack(alignment: .leading) {
                        Text("Sí, ya he manejado")
                            .font(.figtree(size: 17, weight: .semiBold))
                            .foregroundColor(.arrowRed)
                        Text("Selecciona esta opción si ya has tenido experiencia previa con cuentas bancarias.")
                            .font(.figtree(size: 13, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 16)
            .onTapGesture {
                print("MOVER A LA SIG")
                currentStep += 1
            }
            
            
            HStack{
                Circle()
                
                    .fill(Color(UIColor.systemGray5))
                    .shadow(radius: 2, x: 0, y: 1)
                    .frame(width: 40, height: 40)
                    .overlay{
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.gray)
                    }
                
                HStack{
                    VStack(alignment: .leading) {
                        Text("No, no he manejado")
                            .font(.figtree(size: 17, weight: .semiBold))
                            .foregroundColor(.arrowRed)
                        Text("Elige esta opción si es la primera vez que \nvas a manejar una cuenta bancaria.")
                            .font(.figtree(size: 13, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 16)

    Spacer()
            
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TarjetaIdealView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    @State private var selectedCategory = "Clásica"  // Categoría seleccionada
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Título
            (Text("Tu tarjeta ")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
            + Text("ideal")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.red)
            )
            
            // Categorías de tarjetas
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    CategoryButton(title: "Clásica", selectedCategory: $selectedCategory)
                    CategoryButton(title: "Por Ti", selectedCategory: $selectedCategory)
                    CategoryButton(title: "Mujeres", selectedCategory: $selectedCategory)
                    CategoryButton(title: "Platinum", selectedCategory: $selectedCategory)
                        .disabled(true)
                }
            }
            
            // Tarjeta correspondiente a la categoría seleccionada
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))  // Tarjeta Placeholder
                .frame(height: 200)
                .overlay(
                    tarjetaView(for: selectedCategory)
                        .padding()
                )
                .padding(.vertical, 16)
            
            // Beneficios
            VStack(alignment: .leading, spacing: 16) {
                Text("Beneficios")
                    .font(.custom("Poppins-Bold", size: 22))
                    .foregroundColor(.black)
                
                ForEach(beneficios(for: selectedCategory), id: \.title) { beneficio in
                    BeneficioView(icon: beneficio.icon, title: beneficio.title, description: beneficio.description)
                }
            }
            
            Spacer()
            
            // Botón Seleccionar Tarjeta
            Button(action: {
                // Acción para seleccionar tarjeta
                currentStep += 1
            }) {
                Text("Seleccionar Tarjeta")
                    .font(.figtree(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedCategory == "Clásica" ? Color.red : Color(UIColor.systemGray5))
                    .cornerRadius(24)
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Tarjeta correspondiente a la categoría seleccionada
    func tarjetaView(for category: String) -> some View {
        switch category {
        case "Clásica":
            return Text("Tarjeta Clásica Placeholder")
                .foregroundColor(.gray)
                .font(.figtree(size: 20, weight: .regular))
        case "Por Ti":
            return Text("Tarjeta Por Ti Placeholder")
                .foregroundColor(.gray)
                .font(.figtree(size: 20, weight: .regular))
        case "Mujeres":
            return Text("Tarjeta Mujeres Placeholder")
                .foregroundColor(.gray)
                .font(.figtree(size: 20, weight: .regular))
        default:
            return Text("Tarjeta Placeholder")
                .foregroundColor(.gray)
                .font(.figtree(size: 20, weight: .regular))
        }
    }
    
    // Beneficios según la categoría seleccionada
    func beneficios(for category: String) -> [Beneficio] {
        switch category {
        case "Clásica":
            return [
                Beneficio(icon: "creditcard.fill", title: "Sin Anualidad", description: "Ideal para que comiences a usar tu tarjeta sin preocuparte por costos adicionales."),
                Beneficio(icon: "lock.fill", title: "Protección contra Fraude", description: "Con monitoreo constante de actividades inusuales para mantener seguro tu dinero."),
                Beneficio(icon: "sparkles", title: "Promociones Exclusivas", description: "En entretenimiento, viajes y restaurantes, para que disfrutes de experiencias únicas.")
            ]
        case "Por Ti":
            return [
                Beneficio(icon: "calendar", title: "Meses sin Intereses", description: "Ajusta los pagos de meses sin intereses de tus compras en plazos de 3, 6 o 12 meses."),
                Beneficio(icon: "dollarsign.circle.fill", title: "Cashback en Compras", description: "Recibe un porcentaje de tus compras cotidianas y ahorra más."),
                Beneficio(icon: "airplane", title: "Acceso a Salas VIP", description: "Acceso a salas VIP en aeropuertos y eventos exclusivos.")
            ]
        case "Mujeres":
            return [
                Beneficio(icon: "creditcard.fill", title: "Sin Anualidad", description: "Ideal para que comiences a usar tu tarjeta sin preocuparte por costos adicionales."),
                Beneficio(icon: "lock.fill", title: "Protección contra Fraude", description: "Con monitoreo constante de actividades inusuales para mantener seguro tu dinero."),
                Beneficio(icon: "sparkles", title: "Promociones Exclusivas", description: "En entretenimiento, viajes y restaurantes, para que disfrutes de experiencias únicas.")
            ]
        default:
            return []
        }
    }
}

struct Beneficio {
    let icon: String
    let title: String
    let description: String
}

struct CategoryButton: View {
    var title: String
    @Binding var selectedCategory: String
    
    var body: some View {
        Button(action: {
            selectedCategory = title
        }) {
            Text(title)
                .font(.figtree(size: 17, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundStyle(selectedCategory != title ?Color(UIColor.systemGray4) : .black)
                .background(selectedCategory == title ? Color(UIColor.systemGray6) : Color.clear)
                .cornerRadius(16)
        }
        .foregroundColor(.black)
        
    }
}

struct BeneficioView: View {
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(UIColor.systemGray6))
                    .shadow(radius: 2, x: 0, y: 1)
                    .frame(width: 50, height: 50)
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.figtree(size: 17, weight: .semiBold))
                    .foregroundColor(.red)
                Text(description)
                    .font(.figtree(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 16)
        }
    }
}

struct SeguridadView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Título
            (Text("Para ")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.black)
            + Text("Finalizar")
                .font(.custom("Poppins-Bold", size: 28))
                .foregroundColor(.red)
            )
            
            // Subtítulo
            Text("Elige una forma para entrar a tu cuenta.")
                .font(.figtree(size: 17, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, -16)  // Espacio entre subtítulo y botones
            
            
            HStack{
                Circle()
                    .fill(Color(UIColor.systemGray5))
                    .shadow(radius: 2, x: 0, y: 1)
                    .frame(width: 40, height: 40)
                    .overlay{
                        Image(systemName: "faceid")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)
                    }
                HStack{
                    VStack(alignment: .leading) {
                        Text("Biométricos")
                            .font(.figtree(size: 17, weight: .semiBold))
                            .foregroundColor(.arrowRed)
                        Text("Utiliza FaceID para acceder.")
                            .font(.figtree(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 16)
            
            HStack{
                Circle()
                    .fill(Color(UIColor.systemGray5))
                    .shadow(radius: 2, x: 0, y: 1)
                    .frame(width: 40, height: 40)
                    .overlay{
                        Image(systemName: "lock")
                            .resizable()
                            .frame(width: 18, height: 24)
                            .foregroundColor(.gray)
                    }
                HStack{
                    VStack(alignment: .leading) {
                        Text("PIN")
                            .font(.figtree(size: 17, weight: .semiBold))
                            .foregroundColor(.arrowRed)
                        Text("Utiliza un PIN de 4 dígitos para acceder.")
                            .font(.figtree(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 16)

            
            HStack{
                Circle()
                    .fill(Color(UIColor.systemGray5))
                    .shadow(radius: 2, x: 0, y: 1)
                    .frame(width: 40, height: 40)
                    .overlay{
                        Image(systemName: "asterisk")
                            .resizable()
                            .frame(width: 20, height: 23)
                            .foregroundColor(.gray)

                    }
                HStack{
                    VStack(alignment: .leading) {
                        Text("Contraseña")
                            .font(.figtree(size: 17, weight: .semiBold))
                            .foregroundColor(.arrowRed)
                        Text("Utiliza una contraseña para acceder.")
                            .font(.figtree(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 16)


            
            
            HStack{
                Circle()
                
                    .fill(Color(UIColor.systemGray5))
                    .shadow(radius: 2, x: 0, y: 1)
                    .frame(width: 40, height: 40)
                    .overlay{
                        Image(systemName: "hand.wave")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(.gray)
                    }
                
                HStack{
                    VStack(alignment: .leading) {
                        Text("Lo Haré Después")
                            .font(.figtree(size: 17, weight: .semiBold))
                            .foregroundColor(.arrowRed)
                        Text("Configura tu acceso despues.")
                            .font(.figtree(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 12)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 16)
            .onTapGesture {
                print("Hello")
                currentStep += 1
            }

    Spacer()
            
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BienvenidaView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()
            
            // Título principal
            (Text("¡")
                .font(.custom("Poppins-Bold", size: 40))
                .foregroundColor(.black)
            + Text("Bienvenido")
                .font(.custom("Poppins-Bold", size: 40))
                .foregroundColor(.red)
            + Text("!")
                .font(.custom("Poppins-Bold", size: 40))
                .foregroundColor(.black)
            )
            
            // Subtítulo
            Text("A el Banco Fuerte de México")
                .font(.figtree(size: 18, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, -16)
            
            Spacer()
            
            // Botón "¡Empecemos!"
            Button(action: {
                // Acción al presionar el botón
                currentStep += 1
            }) {
                Text("¡Empecemos!")
                    .font(.figtree(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(24)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct BienvenidaDosView: View {
    @Binding var currentStep: Int  // Se recibe el índice actual como Binding

    var body: some View {
        @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false

        VStack(alignment: .center, spacing: 16) {
            Spacer()
            
            // Título principal
            (Text("¡")
                .font(.custom("Poppins-Bold", size: 40))
                .foregroundColor(.black)
            + Text("Bienvenido")
                .font(.custom("Poppins-Bold", size: 40))
                .foregroundColor(.red)
            + Text("!")
                .font(.custom("Poppins-Bold", size: 40))
                .foregroundColor(.black)
            )
            
            // Subtítulo
            Text("A el Banco Fuerte de México")
                .font(.figtree(size: 18, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, -16)
            
            Spacer()
            
            // Botón "¡Empecemos!"
            Button(action: {
                // Acción al presionar el botón
                isOnboardingCompleted.toggle()
            }) {
                Text("¡Empecemos!")
                    .font(.figtree(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(24)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}
