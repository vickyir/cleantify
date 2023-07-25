//
//  TabBarButton.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 24/07/23.
//

import SwiftUI

struct TabBarButton: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            if isSelected {
                Circle()
                    .foregroundColor(.softGreen)
                    .frame(width: 70, height: 70)
            }
            
            Button(action: {
                // Call the action closure to update the selected tab
            }) {
                VStack(alignment: .center, spacing: 4) {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                    
                    Text(title)
                        .font(.caption2)
                }
            }
            .tint(.lightWhite)
        }
    }
}


//struct TabBarButton_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarButton(imageName: <#String#>, title: <#String#>, isSelected: <#Bool#>, action: <#() -> Void#>)
//    }
//}
