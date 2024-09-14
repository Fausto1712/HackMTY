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
            }
            .font(.title)
            .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
}

#Preview {
    HeaderAppView(headerText: "Hello, Aztel!")
        .background(Color("ColorPrimary"))
}
