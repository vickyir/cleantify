//
//  ContentView.swift
//  Cleantify Watch App
//
//  Created by Vicky Irwanto on 23/07/23.
//

import SwiftUI
import HealthKit

struct StartView: View {
    
    var workoutTypes: [HKWorkoutActivityType] = [.cycling, .running, .walking]
    
    var body: some View {
        List(workoutTypes){ workoutTypes in
            NavigationLink(workoutTypes.name, destination: Text(workoutTypes.name))
                .padding(
                    EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5)
                )
            
        }
        .listStyle(.carousel)
        .navigationTitle("Workouts")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

extension HKWorkoutActivityType: Identifiable{
    public var id: UInt{
        rawValue
    }
    
    var name: String{
        switch self{
        case .running:
            return "Run"
        case .cycling:
            return "Bike"
        case .walking:
            return "Walk"
        default:
            return ""
        }
    }
}
