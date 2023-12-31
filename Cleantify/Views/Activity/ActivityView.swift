//
//  ActivityView.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 24/07/23.
//

import SwiftUI
import HealthKit

struct Activity: Identifiable {
    let id = UUID()
    var imageName: String
    var points: String
}

struct ActivityView: View {
    
    @State private var showSummary = false
    @State private var showLeaderboard = false
    @State private var workouts: [HKWorkout] = []
    @State private var filteredWorkouts: [HKWorkout] = []
    let gamekitManager = GameKitManager()
    @State private var cleaners: [Cleaner] = []
    @State var score : Int = 0
    @EnvironmentObject var healthKitManager : HealthKitManager
    
    let activities = [
        Activity(imageName: "Sapu", points: "900"),
        Activity(imageName: "Debu", points: "950")
    ]
    
    let leaderboardScores = [
        ListScore(id: UUID(), number: "1", image: "ava1", name: "Rizky", description: "Grand Clean", score: "2350"),
        ListScore(id: UUID(), number: "2", image: "ava2", name: "Me", description: "Cleanaholic", score: "1850"),
        ListScore(id: UUID(), number: "3", image: "ava3", name: "Yusuf", description: "Grand Clean", score: "1200")
    ]
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    VStack{
                        VStack(alignment: .leading){
                            
                            Text("Let's Start Cleaning!")
                                .font(Font.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.darkBlack)
                                .offset(x:-23)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 313, height: 150)
                                .background(Color.darkBlue)
                                .cornerRadius(20)
                            HStack{
                                Image("Pic")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .padding(.leading, 22)
                                
                                VStack(alignment: .leading) {
                                    Text("Monthly Rank")
                                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(.lightWhite)
                                    
                                    Text("Legendary")
                                        .font(Font.system(size: 30, weight: .bold, design: .rounded))
                                        .foregroundColor(.softGreen)
                                        .padding(.bottom, 19)
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
                                    
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 22)
                            }
                        }
                        .padding(.bottom, 5)
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("Activity")
                                    .font(Font.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.darkBlack)
                                Spacer()
                                
                                NavigationLink(destination: ActivitySummaryView(), isActive: $showSummary) {
                                    HStack {
                                        Text("Show More")
                                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundColor(.darkBlack)
                                        
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(.darkBlack)
                                    }
                                }
                                
                            }
                            Text("Explore various cleaning activities and experience their effects on yourself")
                                .font(Font.system(size: 10, weight: .bold, design: .rounded))
                                .foregroundColor(.greyCaption)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            ForEach(workouts.prefix(3), id: \.uuid) { clean in
                                
                                if [.hockey, .golf, .flexibility].contains(clean.workoutActivityType){
                                  
                                    let cleaningName = localizedWorkoutName(for: clean.workoutActivityType)
                                    ActivityListItem(imageName: cleaningName, points:  String(format: "%.0f", clean.totalDistance?.doubleValue(for: .meter()) ?? 0.0))
                                  
                                    
                                }
                                
                                
                                
                                
                            }
                            Spacer()
                        }
                        
                        .onChange(of: workouts){
                            data in
                            score = 0
                            for clean in data{
                                switch clean.workoutActivityType{
                                case .golf:
                                    score += 25
                                case .hockey:
                                    score += 5
                                case .flexibility:
                                    score += 15
                                default:
                                    score += 0
                                }
                            }
                            Task{
                                await gamekitManager.submitScore(score: score)
                            }
                        }
                        
                        VStack{
                            HStack{
                                Text("Leaderboard")
                                    .font(Font.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.darkBlack)
                                Spacer()
                                NavigationLink(destination: RanksView(), isActive: $showLeaderboard) {
                                    HStack {
                                        Text("Show More")
                                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundColor(.darkBlack)
                                        
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(.darkBlack)
                                    }
                                }
                              
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack{
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 313, height: 293)
                                    .background(Color(red: 0.5, green: 0.79, blue: 0.77))
                                    .cornerRadius(20)
                                
                                
                                VStack {
                                
                                    ForEach(cleaners.prefix(3), id: \.id) { cleaner in
                                        LeaderBoard(number: "\(cleaner.rank)",
                                                    imageProfile: ProfileIcon(name: cleaner.name),
                                                    name: String(cleaner.name.prefix(6))+String(Slice(repeating: ".", count: 3)),
                                                    description: "Cleaner",
                                                    score: String(cleaner.score)).padding(.top, 0.0)
                                        
                                    }
                                    
                                   
                                    
                                }
                                
                            }
                        }
                        
                    }
                    .padding(.horizontal, 50)
                    .tint(.softGreen)
                }
                .refreshable{
                    // Check if the authorization status is not determined (i.e., user hasn't made a choice yet)
                    if HKHealthStore().authorizationStatus(for: HKObjectType.workoutType()) == .notDetermined {
                        // Request authorization
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
                    } else {
                        // Authorization already granted or denied, so no need to request again
                        // You can directly fetch workouts here or handle it accordingly
                        healthKitManager.getWorkouts { workouts, error in
                            if let workouts = workouts {
                                DispatchQueue.main.async {
                                    // Filter the workouts based on activity types
                                    self.workouts = workouts
                                }
                            }
                        }
                    }

                }
            }
            .padding(.bottom, 65)
            .navigationBarTitle("Hello Nisa")
            .onAppear{
                // Check if the authorization status is not determined (i.e., user hasn't made a choice yet)
                if HKHealthStore().authorizationStatus(for: HKObjectType.workoutType()) == .notDetermined {
                    // Request authorization
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
                } else {
                    // Authorization already granted or denied, so no need to request again
                    // You can directly fetch workouts here or handle it accordingly
                    healthKitManager.getWorkouts { workouts, error in
                        if let workouts = workouts {
                            DispatchQueue.main.async {
                                // Filter the workouts based on activity types
                                self.workouts = workouts
                            }
                        }
                    }
                }
                
                GameKitManager.shared.authenticatePlayer() { success in
                    if success {
                        GameKitManager.shared.fetchPlayerData { cleaners in
                            self.cleaners = cleaners
//                            Task{
//                                await gamekitManager.submitScore(score: 5)
//                            }
                        }
                    }
                }
            }
        }
    }
    
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
    
}

struct ActivityListItem: View {
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
    }
}

struct ListScore :Identifiable {
    var id: UUID
    var number: String
    var image: String
    var name: String
    var description: String
    var score: String
}

struct ListScoreView: View {
    
    var score: ListScore
    
    var body: some View {
        HStack {
            Text(score.number)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.lightWhite)
                .frame(width: 40, height: 40)
                .background(Color.darkBlue)
                .clipShape(Circle())
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 225, height: 80)
                    .foregroundColor(Color(red: 0.03, green: 0.11, blue: 0.18))
                    .cornerRadius(20)
                
                HStack {
                    Image(score.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(score.name)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                        Text(score.description)
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                        Text(score.score)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.softGreen)
                    }
                }
                .padding(.leading)
            }
        }
        .padding(.vertical, 1)
    }
}


struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
            .environmentObject(HealthKitManager())
    }
}
