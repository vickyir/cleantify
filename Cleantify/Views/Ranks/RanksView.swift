//
//  RanksView.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 24/07/23.
//

import SwiftUI

struct RanksView: View {
    let gamekitManager = GameKitManager()
    @State private var cleaners: [Cleaner] = []
    
    var body: some View {
        VStack(spacing: -15){
            Text("Monthly Leaderboard")
                .font(Font.system(size: 30, weight: .bold, design: .rounded))
                .fontWeight(.bold)
                .padding(.top, 30)
            
            HStack{
                if cleaners.indices.contains(1){
                    let cleanerAtIndex2 = cleaners[1]
                    
                    TopCleanerCard(imageProfile: ProfileIcon(name: cleanerAtIndex2.name), points: String(cleanerAtIndex2.score), color: .darkBlue, rank: cleanerAtIndex2.rank ,name: String(cleanerAtIndex2.name.prefix(6))+String(Slice(repeating: ".", count: 3)).capitalized, height: 109)
                }
                
                if let firstCleaner = cleaners.first {
                    TopCleanerCard(imageProfile: ProfileIcon(name: firstCleaner.name), points: String(firstCleaner.score), color: .lightYellow, rank: firstCleaner.rank, name: String(firstCleaner.name.prefix(6))+String(Slice(repeating: ".", count: 3)).capitalized, height: 151)
                }
                
                if cleaners.indices.contains(2){
                    let cleanerAtIndex3 = cleaners[2]
                    
                    TopCleanerCard(imageProfile: ProfileIcon(name: cleanerAtIndex3.name), points: String(cleanerAtIndex3.score), color: .darkBlue, rank: cleanerAtIndex3.rank ,name: String(cleanerAtIndex3.name.prefix(6))+String(Slice(repeating: ".", count: 3)).capitalized, height: 79)
                }
            }
            
            VStack{
                GeometryReader { geometry in
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .background(Color(red: 0.5, green: 0.79, blue: 0.77))
                        ScrollView {
                            VStack {
                                Group {
                                    if !cleaners.isEmpty {
                                        ForEach(cleaners, id: \.id) { cleaner in
                                            LeaderBoard(number: "\(cleaner.rank)",
                                                        imageProfile: ProfileIcon(name: cleaner.name),
                                                        name: String(cleaner.name.prefix(6))+String(Slice(repeating: ".", count: 3)),
                                                        description: "Cleaner",
                                                        score: String(cleaner.score))
                                        }
                                    } else {
                                        Text("No cleaners available.")
                                            .font(.system(size: 30))
                                            .foregroundColor(.white)
                                        
                                    }
                                }
                            }
                        }.padding(.top, 20)
                    }
                }
            }
        }
        .onAppear {
            GameKitManager.shared.authenticatePlayer() { success in
                if success {
                    GameKitManager.shared.fetchPlayerData { cleaners in
                        self.cleaners = cleaners
//                        Task{
//                            await gamekitManager.submitScore(score: 10)
//                        }
                    }
                }
            }
        }
    }
}

struct RanksView_Previews: PreviewProvider {
    static var previews: some View {
        RanksView()
    }
}
