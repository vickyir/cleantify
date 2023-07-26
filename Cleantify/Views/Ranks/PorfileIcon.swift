//
//  PorfileIcon.swift
//  Cleantify
//
//  Created by Vicky Irwanto on 27/07/23.
//

import SwiftUI

struct ProfileIcon: View {
    let name: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(randomColor())
            
            Text(name.prefix(1))
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(width: 50, height: 50)
    }
    
    private func randomColor() -> Color{
        var randomRed = Double.random(in: 0...1)
        var randomGreen = Double.random(in: 0...1)
        var randomBlue = Double.random(in: 0...1)
        
        var brightness = (0.299 * randomRed + 0.587 * randomGreen + 0.114 * randomBlue)
        
        while brightness > 0.8 {
            randomRed = Double.random(in: 0...1)
            randomGreen = Double.random(in: 0...1)
            randomBlue = Double.random(in: 0...1)
            
            let newBrightness = (0.299 * randomRed + 0.587 * randomGreen + 0.114 * randomBlue)
            
            brightness = newBrightness
        }
        
        return Color(red: randomRed, green: randomGreen, blue: randomBlue)
        
    }
}

struct ProfileIconView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileIcon(name: "Yusuf")
    }
}

