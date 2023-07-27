//
//  ProfileView.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 24/07/23.
//

import SwiftUI

struct AcheivementCard: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
    let progress: Double
}

struct ProfileView: View {
    
    @State private var showAchievement = false
    @State private var cleaner: Cleaner = Cleaner(name: "Nisa", score: 100, rank: 1)

    let gamekitManager = GameKitManager()
    
    let achievementCards: [AcheivementCard] = [
        AcheivementCard(imageName: "gloves", title: "The Explorer", description: "Start a cleaning activity", progress: 0.6),
        AcheivementCard(imageName: "gloves", title: "Legendary", description: "Hit 100 kcal in sweeping activity", progress: 0.8),
        AcheivementCard(imageName: "gloves", title: "The Brave One", description: "Brave enough to wake up and making the bed", progress: 0.4)
    ]
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Profile")
                    .font(Font.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.darkBlack)
                    .padding(.bottom, 30)
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 353, height: 169)
                        .background(Color.darkBlue)
                        .cornerRadius(20)
                    HStack{
                        VStack(alignment: .leading){
                            Text(String(cleaner.name.prefix(5)).capitalized)
                                .font(Font.system(size: 30, weight: .bold, design: .rounded))
                                .foregroundColor(.softGreen)
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Username")
                                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(.lightWhite)
                                    Text("ID")
                                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(.lightWhite)
                                }
                                VStack(alignment: .leading){
                                    Text(String(cleaner.name.prefix(6))+String(Slice(repeating: ".", count: 3)).capitalized)
                                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(.lightWhite)
                                    Text(String(cleaner.id.uuidString.prefix(6)))
                                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(.lightWhite)
                                }
                                .padding(.leading)
                            }
                            .padding(.bottom,5)
                            
                            ProgressView(value: Double(cleaner.score) / 1000.0,
                                         label: {
                                HStack{
                                    Text("Clean Points")
                                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(.lightWhite)
                                    Spacer()
                                    Text(String(cleaner.score))
                                        .font(Font.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.softGreen)
                                }
                            })
                            
                            HStack{
                                Spacer()
                                Text("Legendary")
                                    .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(.lightWhite)
                            }
                            
                        }
                        .padding(.leading, 25)
                        
                        
                        Image("Pic")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding(.trailing, 25)
                        
                    }
                }
                .tint(.softGreen)
                
                
                HStack {
                    Text("Achievements")
                        .font(Font.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.darkBlack)
                    
                    Spacer()
                    
                    NavigationLink(destination: AchievementListView(achievementCards: achievementCards), isActive: $showAchievement) {
                        HStack {
                            Text("Show More")
                                .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.darkBlack)
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.darkBlack)
                        }
                    }
                }
                .padding(.top, 15)
                
                VStack {
                    ForEach(achievementCards.prefix(3)) { card in
                        AchievementCard(achievement: card)
                    }
                }
                .tint(.softGreen)
                Spacer()
            }
            .padding(.horizontal, 20)
            .onAppear{
                GameKitManager.shared.authenticatePlayer() { success in
                    if success {
                        GameKitManager.shared.fetchDataLocalPlayer { cleaner, error in
                            self.cleaner = cleaner ?? Cleaner(name: "Nisa", score: 100, rank: 1)

                        }
                    }
                }
            }
        }
    }
}

struct AchievementCard: View {
    
    let achievement: AcheivementCard
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 353, height: 97)
                .background(Color.darkBlue)
                .cornerRadius(20)
            
            HStack{
                Image(achievement.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .padding(.leading, 20)
                
                VStack(alignment: .leading, spacing: 5){
                    Text(achievement.title)
                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.lightWhite)
                    
                    Text(achievement.description)
                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.lightWhite)
                    
                    ProgressView(value: achievement.progress)
                        .padding(.vertical, 5)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 30)
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
