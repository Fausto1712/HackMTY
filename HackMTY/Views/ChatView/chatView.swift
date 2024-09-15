//
//  chatView.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 15/09/24.
//

import SwiftUI

struct chatView: View {
    @StateObject var userModel = UserSettings()
    
    @EnvironmentObject var router: Router
    
    var chatBots: [String] = ["ChatBot1","ChatBot2","ChatBot3"]
    
    var body: some View {
        VStack{
            HeaderAppView(headerText: "\(NSLocalizedString("Hello", comment: "")), \(userModel.username)!")
                .padding(.top, 15)
            
            HStack{
                Text("Nuestros ")
                    .foregroundColor(.black)
                    .font(.system(size: 17))
                    .fontWeight(.semibold) +
                Text("Chatbots")
                    .foregroundColor(.red)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            
            VStack(spacing: 25){
                ForEach(chatBots.indices, id: \.self) { index in
                    Button {
                        router.navigate(to: .chatBotView(chatBot: index+1))
                    } label: {
                        Image(chatBots[index])
                    }
                }
            }
            .padding(.top)
            
            Spacer()
        }
    }
}

#Preview {
    chatView()
}
