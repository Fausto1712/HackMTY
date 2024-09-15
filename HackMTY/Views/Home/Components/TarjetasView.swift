//
//  TarjetasView.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI
import SwiftData

struct TarjetasView: View {
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject var router: Router
    
    @Query private var expenses: [Expense]
    
    @Binding var cardIndex: Int
    
    var cards: [String]
    
    var body: some View {
        ScrollView{
            HStack{
                TabView(selection: $cardIndex) {
                    ForEach(cards.indices, id: \.self) { index in
                        Image(cards[index])
                            .resizable()
                            .scaledToFit()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .frame(height: 230)
            
            HStack(spacing: 20){
                roundButton(iconName: "arrow.left.arrow.right",foregroundColor: .white, backgroundColor: .vibrantRed, name: "Transferir")
                roundButton(iconName: "arrow.down", foregroundColor: .white, backgroundColor: .vibrantRed, name: "Transferir")
                roundButton(iconName: "creditcard.fill", foregroundColor: .buttonIconGray, backgroundColor: .buttonGray, name: "Transferir")
                roundButton(iconName: "info.circle.fill", foregroundColor: .buttonIconGray, backgroundColor: .buttonGray, name: "Transferir")
                roundButton(iconName: "ellipsis", foregroundColor: .buttonIconGray, backgroundColor: .buttonGray, name: "Transferir")
            }
            .padding(.bottom,15)
            
            Divider()
                .frame(height: 6)
                .background(.buttonGray)
            
            HStack{
                Text("Movimientos")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                Spacer()
            }
            
            ForEach(expenses, id: \.id) { expense in
                expenseReading(expense: expense)
            }
        }
    }
}

struct roundButton: View {
    var iconName: String
    var foregroundColor: Color
    var backgroundColor: Color
    var name: String
    
    var body: some View {
        Button {
            print(name)
        } label: {
            VStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: 55, height: 55)
                    .foregroundStyle(foregroundColor)
                    .background(backgroundColor)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                
                Text(name)
                    .font(.system(size: 13))
                    .foregroundStyle(.black)
                    .fontWeight(.medium)
            }
        }
    }
}

struct expenseReading:View {
    @EnvironmentObject var router: Router
    
    var expense: Expense
    
    var body: some View {
        Button{
            router.navigate(to: .mapView(expense: expense))
        } label: {
            VStack(alignment: .leading){
                HStack{
                    Text(expense.title)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundStyle(.vibrantRed)
                    Spacer()
                    Text(expense.amount > 0 ? "+$\(String(format: "%.0f", expense.amount))" : "-$\(String(format: "%.0f", abs(expense.amount)))")
                        .foregroundStyle(expense.amount > 0 ? .positiveGreen : .black)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                }
                Text(expense.category)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                Text(expense.date)
                    .font(.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundStyle(.buttonIconGray)
            }
            .padding()
        }
    }
}

#Preview {
    TarjetasView(cardIndex: .constant(0), cards: ["Card1", "Card2"])
}
