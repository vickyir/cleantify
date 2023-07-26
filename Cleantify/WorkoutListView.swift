//
//  WorkoutListView.swift
//  Cleantify
//
//  Created by Vicky Irwanto on 25/07/23.
//

import SwiftUI
import HealthKit


struct WorkoutListView: View {
    @State private var workouts: [HKWorkout] = []
    @State private var filteredWorkouts: [HKWorkout] = []
    let healthKitManager = HealthKitManager()
    
    func localizedWorkoutName(for activityType: HKWorkoutActivityType) -> String {
        switch activityType {
        case .hockey:
            return NSLocalizedString("Sweep", comment: "Sweep cleaning activity type")
        case .golf:
            return NSLocalizedString("Mop", comment: "Mop cleaning activity type")
        case .flexibility:
            return NSLocalizedString("Cleaning Bed", comment: "Cleaning Bed cleaning activity type")
        default:
            return NSLocalizedString("Unknown", comment: "Unknown cleaning activity type")
        }
    }
    
    func durationInMinutes(duration: TimeInterval) -> String {
        let minutes = Int(duration / 60)
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        NavigationView {
            ForEach(workouts, id: \.uuid){
                workouts in
                let workoutName =  localizedWorkoutName(for: workouts.workoutActivityType)
                Text("\(workoutName)")
            }
            List(filteredWorkouts, id: \.uuid) { workout in
                VStack(alignment: .leading) {
                    
                    let workoutName = localizedWorkoutName(for: workout.workoutActivityType)
                    Text("\(workoutName)")
                    
                    Text("Duration: \(durationInMinutes(duration: workout.duration))")
                    Text("Energy Burn: \(String(format: "%.2f", workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0.0)) kcal")
                    Text("Total Movements : \(String(format: "%.0f",workout.totalDistance?.doubleValue(for: .meter()) ?? 0.0) ) ")
                }
            }
            .navigationBarTitle("Workouts")
            .onAppear {
                healthKitManager.requestAuthorization { success, error in
                    if success {
                        healthKitManager.getWorkouts { workouts, error in
                            if let workouts = workouts {
                                DispatchQueue.main.async {
                                    // Filter the workouts based on activity types
                                    self.workouts = workouts
                                    // Filter the workouts based on activity types
                                    let mostFrequentActivityType = self.findMostFrequentActivityType(in: workouts)
                                    self.filteredWorkouts = workouts.filter { $0.workoutActivityType == mostFrequentActivityType }
                                }
                            }
                        }
                    } else if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    // Function to find the most frequent activity type in workouts array
    private func findMostFrequentActivityType(in workouts: [HKWorkout]) -> HKWorkoutActivityType? {
        let activityTypeCounts = workouts.reduce(into: [:]) { counts, workout in
            counts[workout.workoutActivityType, default: 0] += 1
        }
        return activityTypeCounts.max(by: { $0.value < $1.value })?.key
    }
}
struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}
