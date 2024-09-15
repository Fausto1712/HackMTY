//
//  HeaderAppView.swift
//
//  Created by Fausto Pinto
//

import SwiftUI

struct HeaderAppView: View {
    @State private var showingSheet = false
    @EnvironmentObject var router: Router
    @StateObject var userModel = UserSettings()

    let headerText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button {
                    router.navigate(to: .usersettings)
                } label: {
                    Image("\(userModel.picture)")
                        .resizable()
                        .scaledToFit()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .frame(width: 35)
                }
                
                Text(headerText)
                    .padding(.leading, 6)
                
                Spacer()
                
                Image(systemName: "bell.badge")
                    .foregroundStyle(.iconGray)
            }
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.vibrantRed)
            
            Divider()
                .background(Color.gray.opacity(0.5))
                .padding(.horizontal, -16)
        }
        .padding(.horizontal)
    }
}

struct ChatBotHeaderView: View {
    @State private var showingSheet = false
    
    @EnvironmentObject var router: Router
    
    @StateObject var userModel = UserSettings()
    
    var chatBotTitle: String
    
    var body: some View {
        HStack{
            Button{
                router.navigateBack()
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .foregroundStyle(.arrowRed)
            }
            
            Spacer()
            
            Text("Chatbot - \(chatBotTitle)")
                .font(.system(size: 17))
                .fontWeight(.semibold)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    if false {
        HeaderAppView(headerText: "Hello, Aztel!")
            .background(Color("ColorPrimary"))
    } else {
        ChatBotHeaderView(chatBotTitle: "Créditos")
    }
}
