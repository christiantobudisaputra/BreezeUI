//
//  ContentView.swift
//  Playground
//
//  Created by Christianto Budisaputra on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    let imageUrls: [String] = [
        "https://images.unsplash.com/photo-1661956601030-fdfb9c7e9e2f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1342&q=80",
        "https://images.unsplash.com/photo-1673546804014-1b0306317155?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1673725437510-fe7bc808c306?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60"
    ]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            BZCarousel<AnyView>(contentUrls: imageUrls)
                .frame(height: 240)
                .cornerRadius(16)
                .clipped()
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
