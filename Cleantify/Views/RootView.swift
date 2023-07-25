//
//  RootView.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 24/07/23.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .activity
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.lightWhite.edgesIgnoringSafeArea(.all) // Set background color for the entire view
            
            VStack {
                // Your content here (activity, ranks, or profile views)
                switch selectedTab {
                case .activity:
                    ActivityView()
                case .ranks:
                    RanksView()
                case .profile:
                    ProfileView()
                }
            }

            
            CustomTabBar(selectedTab: $selectedTab)
                .background(Color.lightWhite) // Set background color for the CustomTabBar
        }
    }

}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
