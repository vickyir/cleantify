//
//  RanksView.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 24/07/23.
//

import SwiftUI

struct RanksView: View {
    var body: some View {
        VStack{
            Text("Hello, Welcome to Ranks View")
                .font(Font.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.darkBlack)
        }
        
    }
}

struct RanksView_Previews: PreviewProvider {
    static var previews: some View {
        RanksView()
    }
}
