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
            Color.lightWhite
            
            VStack {
                
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
                .background(Color.lightWhite)
                .padding(.bottom,-35)
        }
    }

}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
