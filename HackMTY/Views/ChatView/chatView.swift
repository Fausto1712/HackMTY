import SwiftUI

struct chatView: View {
    @State private var prompt: String = ""
    @State private var chatMessages: [String] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let userData = "Nacionalidad: Mexicano, Nombre: Fausto, Edad: 24, Sueldo: 12,000"
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(chatMessages, id: \.self) { message in
                        if message.hasPrefix("User:") {
                            Text(message)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        } else if message.hasPrefix("Server:") {
                            // Parse and format server response
                            let serverMessage = message.replacingOccurrences(of: "Server: ", with: "")
                            let formattedMessage = parseServerResponse(serverMessage)
                            formattedMessage
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
                TextField("Type your message...", text: $prompt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Send") {
                    sendFormData()
                }
                .padding()
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
    
    func parseServerResponse(_ response: String) -> Text {
        let parsedLines = response.components(separatedBy: "\n")
        var formattedText = Text("")
        
        // Attempt to parse, and format text between '**' as bold
        for line in parsedLines {
            var processedLine = line
            var isBold = false
            
            while let boldRange = processedLine.range(of: "\\*\\*[^\\*]+\\*\\*", options: .regularExpression) {
                let boldText = String(processedLine[boldRange])
                    .replacingOccurrences(of: "**", with: "") // Remove the asterisks
                
                // Break the text into parts
                let beforeBold = processedLine[..<boldRange.lowerBound]
                let afterBold = processedLine[boldRange.upperBound...]
                
                // Add the normal and bold text in parts
                formattedText = formattedText + Text(String(beforeBold))
                formattedText = formattedText + Text(boldText).bold()
                
                processedLine = String(afterBold)
                isBold = true
            }
            
            // Append the remaining non-bold text
            if !isBold {
                formattedText = formattedText + Text("\(processedLine)\n")
            } else {
                formattedText = formattedText + Text("\n")
            }
        }
        
        return formattedText
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
