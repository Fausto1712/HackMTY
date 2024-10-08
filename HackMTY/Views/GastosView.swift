//
//  GastosView.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI
import SwiftData

struct GastosView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var expenses: [Expense]
    
    @StateObject var userModel = UserSettings()
    
    @State var selectedDonutName: String = "Toca una categoria"
    @State var selectedDonutValue: String = ""
    @State var selectedDonutPercentage: CGFloat = 0.00
    @State var totalExpenses: Double = 0.00
    @State private var selectedSegment = "BAJO"
    @State private var transactions = ""
    @State private var userData = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var serverSavingsResponse = ""
    @State private var stats: [String: Double] = [:]
    @State private var suggestions: [String: String] = [:]
    @State private var visibleAdvice: String? = nil
    @State private var categories: [Category] = []
    let categoryColors: [String: Color] = [
        "Entretenimiento": .graph3,
        "Electrónica": .graph1,
        "Restaurante": .graph2,
        "Servicios": .arrowRed,
        "Supermercado": .graph4,
        "Transporte": .graph5,
        "Ropa y calzado": .graph6
    ]
    
    var body: some View {
        ScrollView {
            HeaderAppView(headerText: "\(NSLocalizedString("Hello", comment: "")), \(userModel.username)!")
                .padding(.top, 15)
            
            ZStack {
                DonutChart(dataModel: ChartDataModel.init(dataModel: categories), onTap: {
                    dataModel in
                    if let dataModel = dataModel {
                        selectedDonutValue = "\(String(format: "%.2f", dataModel.chartValue * totalExpenses))$"
                        selectedDonutName = "\(dataModel.name)"
                        selectedDonutPercentage = dataModel.chartValue
                        
                    } else {
                        selectedDonutValue = "\(String(format: "%.2f", totalExpenses))$"
                        selectedDonutName = "Toca una categoria"
                        selectedDonutPercentage = 0.00
                    }
                })
                .frame(width: 250, height: 250, alignment: .center)
                .padding()
                
                VStack{
                    Text(selectedDonutValue)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Text(selectedDonutName)
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(width: 250, height: 250, alignment: .center)
            .padding()
            
            HStack{
                Text("Sugerencias")
                    .padding(.horizontal)
                    .foregroundColor(.vibrantRed)
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                Spacer()
            }
            
            HStack{
                Text(suggestions[selectedDonutName] ?? "No advice available")
                    .lineSpacing(5)
                    .padding(.horizontal)
                    .padding(.top, 5)
                    .foregroundColor(.black)
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .frame(height: 100)
                Spacer()
            }
            
            HStack {
                ZStack{
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(categoryColors[selectedDonutName] ?? .gray)
                    Circle()
                        .frame(width:35, height: 35)
                        .foregroundStyle(.white)
                }
                if selectedDonutName == "Toca una categoria" {
                    Text("\(selectedDonutName) para obtener mas informacion")
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                } else {
                    Text("\(selectedDonutName) representa un \(selectedDonutPercentageAsPercentage()) de tus gastos totales.")
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                }
            }
            .padding(.horizontal)
            
            HStack{
                Text("Nivel de ")
                    .foregroundColor(.black)
                    .font(.system(size: 17))
                    .fontWeight(.semibold) +
                Text("Ahorro")
                    .foregroundColor(.red)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            
            Picker("Select Level", selection: $selectedSegment) {
                Text("BAJO").tag("BAJO")
                Text("MEDIO").tag("MEDIO")
                Text("ALTO").tag("ALTO")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            HStack{
                Text(serverSavingsResponse)
                    .lineSpacing(5)
                    .padding(.horizontal)
                    .padding(.top, 5)
                    .foregroundColor(.black)
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                Spacer()
            }
            
            Spacer()
        }
        .scrollIndicators(.hidden)
        .onAppear { if categories.isEmpty{ fetchData()} }
        .onChange(of: selectedSegment){
            if selectedDonutName != "Toca una categoria" {
                sendFormData()
            }
        }
        .onChange(of: selectedDonutName){
            if selectedDonutName != "Toca una categoria" {
                sendFormData()
            }
        }
    }
    
    func fetchData() {
        guard !expenses.isEmpty else {print("No data to review"); return }
        
        for expense in expenses {
            transactions = transactions + "\(expense.title): \(expense.amount), "
            totalExpenses =  totalExpenses + expense.amount
        }
        
        userData = "Nombre: \(userModel.username), Apellido: \(userModel.lastName), Sueldo: \(userModel.sueldo), Sexo: \(userModel.sex), Pais de residencia: \(userModel.country), EstadoCivil: \(userModel.estadoCivil), Ocupacion: \(userModel.ocupation), Cumpleaños: \(userModel.birthday)"
        
        let url = URL(string: "https://3jc8w5qb-8000.usw3.devtunnels.ms/stats2")!
        
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"transactions\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(transactions)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"userData\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(userData)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Error: \(error.localizedDescription)"
                    showAlert = true
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        alertMessage = "Status Code: \(response.statusCode)"
                        showAlert = true
                        return
                    }
                }
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(APIResponse.self, from: data) {
                        stats = [:]
                        suggestions = [:]
                        self.stats = decodedResponse.stats
                        self.suggestions = parseSuggestions(decodedResponse.suggestions)
                        for stat in stats {
                            let color = categoryColors[stat.key] ?? .gray
                            categories.append(Category(color: color, chartValue: stat.value, name: stat.key))
                        }
                    } else {
                        alertMessage = "Failed to parse server response"
                        showAlert = true
                    }
                }
            }
        }.resume()
    }
    
    func sendFormData() {
        let url = URL(string: "https://3jc8w5qb-8000.usw3.devtunnels.ms/chat2/Ahorros")!
        userData = userData + ", nivelDeAhorro: \(selectedSegment)"
        let prompt = "Considerando mi nivel de ahorro y la siguiente sugerencia dame opcoines especificas para ahorrar " + (suggestions[selectedDonutName] ?? "")
        
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"prompt\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(String(describing: prompt)))\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"userData\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(userData)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Error: \(error.localizedDescription)"
                    showAlert = true
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        alertMessage = "Status Code: \(response.statusCode)"
                        showAlert = true
                        return
                    }
                }
                
                if let data = data {
                    if let jsonResponse = try? JSONDecoder().decode(ServerResponse.self, from: data) {
                        serverSavingsResponse = jsonResponse.response
                    } else {
                        alertMessage = "Failed to parse server response"
                        showAlert = true
                    }
                }
            }
        }.resume()
    }
    
    func selectedDonutPercentageAsPercentage() -> String {
        let percentage = selectedDonutPercentage * 100
        return String(format: "%.2f%%", percentage)
    }
    
    func parseSuggestions(_ suggestionsText: String) -> [String: String] {
        var suggestionsDict: [String: String] = [:]
        let lines = suggestionsText.split(separator: "\n").map { String($0) }
        
        for line in lines {
            if line.contains(": ") {
                let components = line.split(separator: ": ", maxSplits: 1).map { String($0) }
                if components.count == 2 {
                    let category = components[0].replacingOccurrences(of: "- ", with: "").trimmingCharacters(in: .whitespaces)
                    suggestionsDict[category] = components[1]
                }
            }
        }
        return suggestionsDict
    }
}

struct APIResponse: Codable {
    let stats: [String: Double]
    let suggestions: String
}

#Preview {
    GastosView()
}
