//
//  CleaningViewModel.swift
//  Cleantify
//
//  Created by Vicky Irwanto on 25/07/23.
//

import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    let healthStore = HKHealthStore()
    @Published var checkPermission : Bool = false
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let readTypes: Set<HKObjectType> = [
            HKObjectType.workoutType()
            // Jika Anda ingin mengakses data kesehatan lain, tambahkan jenisnya di sini.
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: readTypes) { (success, error) in
            completion(success, error)
        }
    }
    
    func getWorkouts(completion: @escaping ([HKWorkout]?, Error?) -> Void) {
        let workoutType = HKObjectType.workoutType()
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: workoutType, predicate: nil, limit: 0, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            guard let workouts = samples as? [HKWorkout], error == nil else {
                completion(nil, error)
                return
            }
            completion(workouts, nil)
        }
        healthStore.execute(query)
    }
    
    func getWorkoutEnergyBurn(workout: HKWorkout, completion: @escaping (Double?, Error?) -> Void) {
           let energyBurnType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
           let predicate = HKQuery.predicateForObjects(from: workout)
           let query = HKStatisticsQuery(quantityType: energyBurnType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, statistics, error) in
               guard let statistics = statistics, let sum = statistics.sumQuantity() else {
                   completion(nil, error)
                   return
               }
               let energyBurn = sum.doubleValue(for: HKUnit.kilocalorie())
               completion(energyBurn, nil)
           }
           healthStore.execute(query)
       }
}

