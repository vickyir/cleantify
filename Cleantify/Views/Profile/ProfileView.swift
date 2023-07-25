//
//  ProfileView.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 24/07/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            Text("Hello, Welcome to Profile View")
                .font(Font.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.darkBlack)
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
