//
//  LeaderBoard.swift
//  Cleantify
//
//  Created by Vicky Irwanto on 27/07/23.
//

import SwiftUI

struct LeaderBoard: View {
    var number: String
    var imageProfile: ProfileIcon
    var name: String
    var description: String
    var score: String
    
    var body: some View {
        HStack {
            Text(number)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.lightWhite)
                .frame(width: 40, height: 40)
                .background(Color.darkBlue)
                .clipShape(Circle())
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 225, height: 80)
                    .foregroundColor(Color(red: 0.03, green: 0.11, blue: 0.18))
                    .cornerRadius(20)
                
                HStack{
                    ProfileIcon(name: name)
                    
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                        Text(description)
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                        Text(score)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.softGreen)
                    }
                }.padding(.leading, 15)
            }
            
            HStack{
                Image("ArrowDownColor")
                    .resizable()
                    .frame(width: 32, height: 30)
                Text("1")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
            }
        }
    }
}

struct LeaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoard(number: "13",
                    imageProfile: ProfileIcon(name: "cleaner.name"),
                    name: String("cleaner.name".prefix(6))+String(Slice(repeating: ".", count: 3)),
                    description: "Cleaner",
                    score: "7893")
    }
}
