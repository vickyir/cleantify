//
//  TopCleanerCard.swift
//  Cleantify
//
//  Created by Vicky Irwanto on 27/07/23.
//

import SwiftUI

struct TopCleanerCard: View {
    let imageProfile: ProfileIcon
    let points: String
    let color: Color
    let rank: Int
    let name: String
    let height: CGFloat
    
    var body: some View {
        VStack{
            Spacer()
            Text(name)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.darkBlue)
                .padding(.bottom, -10)
            ProfileIcon(name: name)
            Text("\(points)")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.darkBlue)
                .padding(.bottom, -25)
            
            ZStack {
                Rectangle()
                    .fill(color)
                    .frame(width: 80, height: height)
                    .cornerRadius(20)
                
                Text("\(rank)")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
    }
}

struct TopCleanerCardView_Previews: PreviewProvider {
    static var previews: some View {
        TopCleanerCard(imageProfile: ProfileIcon(name: "Yusuf"), points: "2000", color: .lightYellow, rank: 10, name: String("Yusuf".prefix(6))+String(Slice(repeating: ".", count: 3)).capitalized, height: 151)
    }
}
