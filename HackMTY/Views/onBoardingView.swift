//
//  onBoarding.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI

struct onBoardingView: View {
    // AppStorage for onboarding
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    @StateObject var userModel = UserSettings()
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack{
            Text("On boarding")
            Button {
                isOnboardingCompleted = validInfo()
                router.navigate(to: .contentView)
            } label: {
                Text("Complete Onboarding")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func validInfo() -> Bool {
        userModel.username = "Fausto Pinto"
        userModel.email = "fausto.pintocabrera@gmail.com"
        userModel.picture = "person2"
        return true
    }
}

#Preview {
    onBoardingView()
}
