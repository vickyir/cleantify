//
//  CleantifyApp.swift
//  Cleantify Watch App
//
//  Created by Vicky Irwanto on 23/07/23.
//

import SwiftUI

@main
struct Cleantify_Watch_AppApp: App {
    @StateObject private var workoutManager = WorkoutManager()
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }
            .sheet(isPresented: $workoutManager.showingSummaryView) {
                SummaryView()
            }
            .environmentObject(workoutManager)
        }
    }
}
