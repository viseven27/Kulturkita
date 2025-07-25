//
//  ContentView.swift
//  Kulturkita
//
//  Created by Alvin Justine on 23/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                //1. Ruang kosong di atas
                Spacer()
                //2. Judul, logo, dan tombol
                VStack {
                    Text("Kulturkita")
                    Image("KulturkitaLogo")
                    NavigationLink(destination: ARContentView()){
                        Text("Click Me")
                            .padding(24)
                            .background(Color.yellow)
                            .foregroundColor(.brown)
                            .cornerRadius(40)
                    }
                }
                Spacer()
                //3.
                HStack {
                    VStack {
                        Button("Stamp"){
                            print(" ")
                        }
                        Text("Stempel")
                    }
                    Spacer()
                    
                    VStack{
                        Button("Map"){
                            print("")
                        }
                        Text("Peta")
                    }
                }
                
            }
            .padding()
            .background(Color.yellow.opacity(0.2))
            .ignoresSafeArea()
        }
    }
    
}

#Preview {
    ContentView()
}
