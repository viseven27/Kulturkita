//
//  ContentView.swift
//  Kulturkita
//
//  Created by Alvin Justine on 23/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            //1. Ruang kosong di atas
            Spacer()
            //2. Judul, logo, dan tombol
            VStack {
                Text("Kulturkita")
                Image("KulturkitaLogo")
                Button("Click Me") {
                    // Action here
                    print("Button was tapped")
                }
                .foregroundColor(.brown)
                .background(Color.yellow)
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
    }
}

#Preview {
    ContentView()
}
