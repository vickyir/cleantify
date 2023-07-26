//
//  ActivitySummaryView.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 25/07/23.
//

import SwiftUI
import HealthKit

struct SummaryActivity: Identifiable {
    let id = UUID()
    var imageName: String
    var points: String
}
struct ActivityDetail: Identifiable {
    let id = UUID()
    var imageName: String
    var name: String
    var totalTime: String
    var totalKcal: String
    var distance: String
    var avgPace: String
}

struct ActivitySummaryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let activities = [
        Activity(imageName: "Sapu", points: "900"),
        Activity(imageName: "Debu", points: "950")
    ]
    
    let activitiesdetail = [
        ActivityDetail(imageName: "Sapu", name: "Mopping", totalTime: "09:02:19", totalKcal: "578 KCAL", distance: "115km", avgPace: "16'08\"/km"),
        ActivityDetail(imageName: "Sapu", name: "Sweeping", totalTime: "10:44:08", totalKcal: "768 KCAL", distance: "2.23km", avgPace: "19'12\"/km")
    ]
    
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
    
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    VStack(alignment: .leading){
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 353, height: 180)
                                .background(Color.darkBlue)
                                .cornerRadius(20)
                            VStack(alignment: .leading){
                                ProgressView(value: 0.6,
                                             label: {
                                    HStack{
                                        Text("Clean Points")
                                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundColor(.lightWhite)
                                        Spacer()
                                        Text("1850")
                                            .font(Font.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(.softGreen)
                                        
                                    }
                                })
                                Text("*clean point will be reset on every end of the month")
                                    .font(Font.system(size: 10, design: .rounded))
                                    .foregroundColor(.lightWhite)
                                    .offset(y:-5)
                                    .padding(.bottom, 10)
                                
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("Total Points")
                                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundColor(.lightWhite)
                                        Text("5400")
                                            .font(Font.system(size: 30, weight: .bold, design: .rounded))
                                            .foregroundColor(.softGreen)
                                    }
                                    .padding(.trailing, 60)
                                    
                                    VStack(alignment: .leading){
                                        Text("Clean Streak")
                                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundColor(.lightWhite)
                                        Text("9 Days")
                                            .font(Font.system(size: 30, weight: .bold, design: .rounded))
                                            .foregroundColor(.softGreen)
                                    }
                                }
                                Text("Points are counted by the calculation of calorie burns and the time that was consumed from cleaning.")
                                    .font(Font.system(size: 10, design: .rounded))
                                    .foregroundColor(.lightWhite)
                            }
                            .padding(.horizontal, 30)
                            
                            
                        }
                        .tint(.softGreen)
                        
                        VStack(alignment: .leading){
                            Text("Your Activity")
                                .font(Font.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.darkBlack)
                            Text("Explore various cleaning activities and experience their effects on yourself.")
                                .font(Font.system(size: 9, weight: .bold, design: .rounded))
                                .foregroundColor(.greyCaption)
                        }
                        .padding(.top, 5)
                        .offset(x:10)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 0.0) {
                                ForEach(workouts, id: \.uuid) { clean in
                                    if [.hockey, .golf, .flexibility].contains(clean.workoutActivityType){
                                        let cleaningName = localizedWorkoutName(for: clean.workoutActivityType)
                                    
                                        SummaryActivityItemView(imageName: cleaningName, points: String(format: "%.0f", clean.totalDistance?.doubleValue(for: .meter()) ?? 0.0))
                                    }
                                
                                }
                                Spacer()
                            }

                        }
                                                
                        VStack(alignment: .leading){
                            Text("Activity Details")
                                .font(Font.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.darkBlack)
                            Text("Take a look on how much you have been through these time.\nYou’re doing great!")
                                .font(Font.system(size: 9, weight: .bold, design: .rounded))
                                .foregroundColor(.greyCaption)
                        }
                        .padding(.top, 5)
                        .offset(x:10)
                        
                        VStack {
                            ForEach(workouts, id:\.uuid) { clean in
                                if [.hockey, .golf, .flexibility].contains(clean.workoutActivityType){
                                    ActivityDetailView(activitydetail: clean)
                                }
                                
                            }
                        }
                        .tint(.softGreen)
                        .padding(.bottom)
                        
                    }
                    .padding(.horizontal, 10)
                }
            }
            .onAppear{
                healthKitManager.requestAuthorization { success, error in
                    if success {
                        healthKitManager.getWorkouts { workouts, error in
                            if let workouts = workouts {
                                DispatchQueue.main.async {
                                    // Filter the workouts based on activity types
                                    self.workouts = workouts
                                }
                            }
                        }
                    } else if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            .padding(.bottom, 65)
            .navigationBarTitle("Activity Summary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // Custom back button to handle the navigation back
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Dismiss the view
                    }) {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.darkBlack)
                        Text("back")
                            .font(Font.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.darkBlack)
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct SummaryActivityItemView: View {
    var imageName: String
    var points: String

    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 0.03, green: 0.11, blue: 0.18))
                .cornerRadius(20)
                .frame(width: 100, height: 120)
            
            VStack(spacing: 0) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                HStack(spacing: 0) {
                    Text(points)
                        .font(Font.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(.lightWhite)
                    
                    Text("move")
                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.lightWhite)
                }
            }
        }
        .padding(.trailing, 15)
    }
}

struct ActivityDetailView: View {
    var activitydetail: HKWorkout
    
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
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 353, height: 130)
                .background(Color.darkBlue)
                .cornerRadius(20)
            
            HStack {
                Image(localizedWorkoutName(for: activitydetail.workoutActivityType))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(localizedWorkoutName(for: activitydetail.workoutActivityType))
                        .font(Font.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.softGreen)
                    
                    Divider()
                        .frame(height: 2)
                        .overlay(Color.lightWhite)
                    
                    HStack {
                        Text("Time")
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                            .padding(.trailing)
                        Spacer()
                        Text("Movements")
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                    }
                    
                    HStack {
                        Text("\(durationInMinutes(duration: activitydetail.duration))")
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.softGreen)
                            .padding(.trailing)
                        Spacer()
                        Spacer()
                        Spacer()
                        Text("\(String(format: "%.0f", activitydetail.totalDistance?.doubleValue(for: .meter()) ?? 0.0))")
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.softGreen)
                        Spacer()
                    }
                    
                }
                .padding(.trailing)
            }
        }
        .padding(.leading, 10)
    }
}
struct ActivitySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySummaryView()
    }
}
