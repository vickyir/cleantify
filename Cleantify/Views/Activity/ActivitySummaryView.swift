//
//  ActivitySummaryView.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 25/07/23.
//

import SwiftUI

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
                        
                        HStack {
                            ForEach(activities) { activity in
                                SummaryActivityItemView(imageName: activity.imageName, points: activity.points)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        
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
                            ForEach(activitiesdetail) { activity in
                                ActivityDetailView(activitydetail: activity)
                            }
                        }
                        .tint(.softGreen)
                        .padding(.bottom)
                        
                    }
                    .padding(.horizontal, 10)
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
                    
                    Text("pts")
                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.lightWhite)
                }
            }
        }
        .padding(.trailing, 15)
    }
}

struct ActivityDetailView: View {
    var activitydetail: ActivityDetail
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 353, height: 130)
                .background(Color.darkBlue)
                .cornerRadius(20)
            
            HStack {
                Image(activitydetail.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(activitydetail.name)
                        .font(Font.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.softGreen)
                    
                    HStack {
                        Text("Total Time")
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                        Text("Total kilocalories")
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                    }
                    
                    HStack {
                        Text(activitydetail.totalTime)
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.softGreen)
                            .padding(.trailing, 7)
                        
                        Text(activitydetail.totalKcal)
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.softGreen)
                    }
                    Divider()
                        .frame(height: 2)
                        .overlay(Color.lightWhite)
                    
                    HStack {
                        Text("Distance")
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                            .padding(.trailing)
                        Text("Avg. Pace")
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                    }
                    
                    HStack {
                        Text(activitydetail.distance)
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.softGreen)
                            .padding(.trailing)
                        
                        Text(activitydetail.avgPace)
                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.softGreen)
                    }
                    
                }
                .padding(.trailing)
            }
        }
        .padding(.leading, 10)
        .padding(.bottom)
    }
}
struct ActivitySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySummaryView()
    }
}
