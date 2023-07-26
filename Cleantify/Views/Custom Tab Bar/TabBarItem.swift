//
//  TabBarItem.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 25/07/23.
//

import SwiftUI

struct TabBarItem: View {
    let tab: Tabs
    @Binding var selectedTab: Tabs
    @Binding var circleOffset: CGFloat
    
    var body: some View {
        ZStack{
            if selectedTab == tab {
                Circle()
                    .foregroundColor(.softGreen)
                    .frame(width: 70, height: 70)
                    .offset(x: circleOffset)
            }
            
            Button(action: {
                withAnimation(.easeInOut) {
                    selectedTab = tab
                    switch tab {
                    case .activity: circleOffset = 0
                    case .ranks: circleOffset = 0.6
                    case .profile: circleOffset = 1.2
                    }
                }
            }) {
                GeometryReader { geo in
                    VStack(alignment: .center, spacing: 4) {
                        if tab.isSFSymbol {
                            Image(systemName: tab.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                        } else {
                            Image(tab.imageName) // Directly use the image name from the asset catalog
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                        }
                        
                        Text(tab.rawValue)
                            .font(.caption2)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .offset(y: 5)
                }
            }
            .tint(.lightWhite)
        }
    }
}

enum Tabs: String, CaseIterable {
    case activity = "Activity"
    case ranks = "Ranks"
    case profile = "Profile"
    
    var imageName: String {
        switch self {
        case .activity: return "activityIcon"
        case .ranks: return "ranksIcon"
        case .profile: return "person.fill"
        }
    }
    
    var isSFSymbol: Bool {
        switch self {
        case .profile:
            return true // Use SF Symbol
        case .ranks, .activity:
            return false // Use Asset Image
        }
    }
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(tab: .activity, selectedTab: .constant(.activity), circleOffset: .constant(0))
    }
}
