//
//  cuentasView.swift
//  HackMTY
//
//  Created by Fausto Pinto Cabrera on 14/09/24.
//

import SwiftUI
struct cuentaDeAhorro{
    var nombre: String
    var numeroTarjeta: String
    var saldo: String
}

struct cuentasView: View {
    var cuentas: [cuentaDeAhorro] = [
        cuentaDeAhorro(nombre: "Banorte Por Ti",
                       numeroTarjeta: "1000ha8109 | •8109",
                       saldo: "$4,000"),
        cuentaDeAhorro(nombre: "Banorte Mujeres",
                       numeroTarjeta:
                        "1000ah9018 | •9018",
                       saldo: "$23,000")]
    var descubres: [String] = ["Descubre1","Descubre2","Descubre3","Descubre4","Descubre5"]
    var anuncios: [String] = ["Anuncio1","Anuncio2"]
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(cuentas.indices, id: \.self) { index in
                    cuentaPill(cuenta: cuentas[index])
                        .padding()
                    if index != cuentas.indices.last {
                        Divider()
                    }
                }
            }
            .frame(width: 350)
            .background(RoundedRectangle(cornerRadius: 12).stroke(.gray.opacity(0.5), lineWidth: 1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            HStack{
                Text("Descubre ")
                    .foregroundColor(.black)
                    .font(.system(size: 17))
                    .fontWeight(.semibold) +
                Text("Banorte")
                    .foregroundColor(.red)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(descubres, id: \.self) { descubre in
                        Image(descubre)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top)
            .padding(.horizontal)
            
            HStack{
                Text("Noticias")
                    .foregroundColor(.black)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(anuncios, id: \.self) { anuncio in
                        Image(anuncio)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top)
            .padding(.horizontal)
        }
    }
}

struct cuentaPill:View {
    var cuenta: cuentaDeAhorro
    var body: some View {
        VStack{
            HStack{
                Text(cuenta.nombre)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundStyle(.vibrantRed)
                Spacer()
                Text(cuenta.saldo)
                    .font(.system(size: 20))
            }
            HStack{
                Text(cuenta.numeroTarjeta)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                Spacer()
                Text("Saldo disponible")
                    .font(.system(size: 13))
                    .foregroundStyle(.accontTextGray)
            }
        }
    }
}

#Preview {
    cuentasView()
}
