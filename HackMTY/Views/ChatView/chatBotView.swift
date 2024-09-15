//
//  chatBotView.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 15/09/24.
//

import SwiftUI

struct chatBotView: View {
    @StateObject var userModel = UserSettings()
    @State private var prompt: String = ""
    @State private var chatMessages: [String] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var chatBotTitle: String = ""
    @State private var messagePlaceHolder: String = ""
    var chatBot: Int
    
    let userData = "Nacionalidad: Mexicano, Nombre: Fausto, Edad: 24, Sueldo: 12,000"
    
    var body: some View {
        VStack {
            ChatBotHeaderView(chatBotTitle: chatBotTitle)
                .padding(.top)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(chatMessages, id: \.self) { message in
                        if message.hasPrefix("User:") {
                            Text(message.replacingOccurrences(of: "User: ", with: ""))
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        } else if message.hasPrefix("Server:") {
                            let serverMessage = message.replacingOccurrences(of: "Server: ", with: "")
                            Text(serverMessage)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .padding()
            
            HStack {
                TextField(messagePlaceHolder, text: $prompt)
                    .font(.system(size: 17))
                    .padding(10)
                    .padding(.horizontal,15)
                    .background(RoundedRectangle(cornerRadius: 34).background(.gray.opacity(0.2)))
                    .clipShape(RoundedRectangle(cornerRadius: 34))
                    .foregroundStyle(.clear)
                
                Button{
                    sendFormData()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                        .frame(width: 45, height: 45)
                        .foregroundStyle(.white)
                        .background(.vibrantRed)
                        .clipShape(Circle())
                }
                .padding(.vertical, 5)
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            if chatBot == 1 {
                chatBotTitle = "Inversiones"
                messagePlaceHolder = "Mi monto es de..."
                chatMessages.append("Server: ¡Hola! Envíame tu monto y elige tu nivel de riesgo para continuar 😎.")
            } else if chatBot == 2 {
                chatBotTitle = "Credito"
                messagePlaceHolder = "Me podrias explicar..."
                chatMessages.append("Server: ¡Hola! Resolvamos tus dudas sobre créditos 😎.")
            } else {
                chatBotTitle = "Ayuda"
                messagePlaceHolder = "Necesito ayuda con..."
                chatMessages.append("Server: ¡Hola! Dime como te puedo asistir 😎.")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func sendFormData() {
        guard !prompt.isEmpty else { return }
        
        chatMessages.append("User: \(prompt)")
        
        let url = URL(string: "https://b5nhsxsx-8000.usw3.devtunnels.ms/chat2/Finanzas")!
        
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"prompt\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(prompt)\r\n".data(using: .utf8)!)
        
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
                        let serverMessage = jsonResponse.response
                        chatMessages.append("Server: \(serverMessage)")
                    } else {
                        alertMessage = "Failed to parse server response"
                        showAlert = true
                    }
                }
            }
        }.resume()
        prompt = ""
    }
}

struct ServerResponse: Codable {
    let response: String
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

#Preview {
    chatBotView(chatBot: 1)
}
