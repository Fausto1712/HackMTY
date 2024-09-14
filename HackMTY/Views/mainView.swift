//
//  mainView.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI

struct mainView: View {
    @EnvironmentObject var router: Router
    @StateObject var userModel = UserSettings()
    
    var body: some View {
        VStack{
            HeaderAppView(headerText: "\(NSLocalizedString("Hello", comment: "")), \(userModel.username)!")
            Spacer()
            Text("Main View")
        }
    }
}

#Preview {
    mainView()
}
