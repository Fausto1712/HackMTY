import SwiftUI

struct chatView: View {
    @State private var prompt: String = ""
    @State private var chatMessages: [String] = [] // Store chat history
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // Hardcoded userData
    let userData = "Nacionalidad: Mexicano, Nombre: Fausto, Edad: 24, Sueldo: 12,000"
    
    var body: some View {
        VStack {
            // Chat view
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(chatMessages, id: \.self) { message in
                        Text(message)
                            .padding()
                            .background(message.hasPrefix("User:") ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: message.hasPrefix("User:") ? .trailing : .leading)
                    }
                }
            }
            .padding()
            
            // Input field for 'prompt'
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
        
        // Append user message to chat
        chatMessages.append("User: \(prompt)")
        
        // Define the URL for the API
        let url = URL(string: "https://b5nhsxsx-8000.usw3.devtunnels.ms/chat2/Finanzas")!
        
        // Create a boundary
        let boundary = UUID().uuidString
        
        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Build the multipart form-data body
        var body = Data()

        // Append 'prompt' field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"prompt\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(prompt)\r\n".data(using: .utf8)!)

        // Append hardcoded 'userData' field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"userData\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(userData)\r\n".data(using: .utf8)!)

        // End the body with boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Set the body of the request
        request.httpBody = body
        
        // Send the request with URLSession
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Show error in alert
                    alertMessage = "Error: \(error.localizedDescription)"
                    showAlert = true
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        // Show non-200 response in alert
                        alertMessage = "Status Code: \(response.statusCode)"
                        showAlert = true
                        return
                    }
                }
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    // Append server response to chat
                    chatMessages.append("Server: \(responseString)")
                }
            }
        }.resume()
        
        // Clear the prompt field after sending
        prompt = ""
    }
}

// Extension to append Data to a Data object
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
