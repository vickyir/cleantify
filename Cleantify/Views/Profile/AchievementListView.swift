//
//  AchievementListView.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 25/07/23.
//

import SwiftUI

struct AchievementListView: View {
    @Environment(\.presentationMode) var presentationMode
    let achievementCards: [AcheivementCard]
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    Text("Achievements")
                        .font(Font.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.darkBlack)
                        .padding(.bottom, 30)
                    
                    ForEach(achievementCards) { card in
                        AchievementCard(achievement: card)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        // Custom back button to handle the navigation back
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // Dismiss the view
                        }) {
                            Image(systemName: "chevron.left")
                                .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.darkBlack)
                            Text("back")
                                .font(Font.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.darkBlack)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct AchievementListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AchievementListView(, achievementCards: <#[AcheivementCard]#>)
//    }
//}
