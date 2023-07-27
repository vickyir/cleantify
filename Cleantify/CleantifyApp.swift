//
//  CleantifyApp.swift
//  Cleantify
//
//  Created by Vicky Irwanto on 23/07/23.
//

import SwiftUI

@main
struct CleantifyApp: App {
    @StateObject var cleanManager = HealthKitManager()
    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(.light)
                .environmentObject(cleanManager)
//            WorkoutListView()
        }
    }
}
