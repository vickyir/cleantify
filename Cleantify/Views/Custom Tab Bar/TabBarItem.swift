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
        ZStack(alignment: .bottom) {
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
                        Image(systemName: tab.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                        
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
        case .activity: return "checkmark.circle"
        case .ranks: return "chart.bar.fill"
        case .profile: return "person.fill"
        }
    }
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(tab: .activity, selectedTab: .constant(.activity), circleOffset: .constant(0))
    }
}
