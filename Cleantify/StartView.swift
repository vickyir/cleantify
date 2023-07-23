//
//  ContentView.swift
//  Cleantify
//
//  Created by Vicky Irwanto on 23/07/23.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
