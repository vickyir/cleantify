//
//  CustomTabBar.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 24/07/23.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tabs
    @State private var circleOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            ForEach(Tabs.allCases, id: \.self) { tab in
                TabBarItem(tab: tab, selectedTab: $selectedTab, circleOffset: $circleOffset)
            }
        }
        .frame(height: 100)
        .background(Color.darkBlue)
        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: -6)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.activity))
    }
}
