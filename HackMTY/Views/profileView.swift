//
//  userSettings.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI

struct profileView: View {
    @StateObject var userModel = UserSettings()
    @EnvironmentObject var router: Router
    
    var body: some View {
        HStack(spacing: 50){
            Image(userModel.picture)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 150)
            VStack(alignment: .leading){
                Text("User: ")
                Text(userModel.username)
                
                Text("Email: ")
                Text(userModel.username)
            }
        }
    }
}

#Preview {
    profileView()
}
