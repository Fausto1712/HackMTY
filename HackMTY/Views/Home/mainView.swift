import SwiftUI
import SwiftData

struct mainView: View {
    @EnvironmentObject var router: Router
    
    @StateObject var userModel = UserSettings()
    
    @Environment(\.modelContext) private var modelContext
    
    // Categories and selected category state
    var categories: [String] = ["Cuentas", "Tarjetas", "Bolsa", "Divisas", "Otros"]
    var cards: [String] = ["Card1", "Card2"]
    
    @State private var selectedCategory: String = "Cuentas"
    @State private var cardIndex = 0

    var body: some View {
        VStack {
            HeaderAppView(headerText: "\(NSLocalizedString("Hello", comment: "")), \(userModel.username)!")
                .padding(.top, 15)
            
            ScrollView(.horizontal) {
                ScrollViewReader { proxy in
                    HStack(spacing: 0) {
                        ForEach(categories.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                Text(categories[index])
                                    .padding()
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                    .background(self.selectedCategory == categories[index] ? Color.accentGray.opacity(0.1) : Color.clear)
                                    .foregroundStyle(self.selectedCategory == categories[index] ? .black : .gray)
                                    .cornerRadius(12)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            self.selectedCategory = categories[index]
                                            proxy.scrollTo(index, anchor: .center)
                                        }
                                    }
                                    .id(index)
                                    .frame(width: 100)
                            }
                            .frame(width: 80)
                        }
                    }
                    .padding()
                }
            }
            .frame(height: 70)
            .scrollIndicators(.hidden)
            
            if selectedCategory == "Cuentas" {
                cuentasView()
            }
            else if selectedCategory == "Tarjetas" {
                TarjetasView(cardIndex: $cardIndex, cards: cards)
            }
            
            Spacer()
        }
    }
}

#Preview {
    mainView()
}
