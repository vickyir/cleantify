//
//  ActivityView.swift
//  CustomNav
//
//  Created by Rizky Dwi Hadisaputro on 24/07/23.
//

import SwiftUI

struct ActivityView: View {
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
                        .padding(.bottom)
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("Activity")
                                    .font(Font.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.darkBlack)
                                Spacer()
                                Button(action: {
                                    
                                }){
                                    HStack {
                                        Text("show more")
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
                        
                        HStack{
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 100, height: 120)
                                    .background(Color(red: 0.03, green: 0.11, blue: 0.18))
                                    .cornerRadius(20)
                                VStack(spacing:0){
                                    Image("Sapu")
                                    
                                    HStack(spacing:0){
                                        Text("900")
                                            .font(Font.system(size: 25, weight: .bold, design: .rounded))
                                            .foregroundColor(.lightWhite)
                                        
                                        Text("pts")
                                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundColor(.lightWhite)
                                    }
                                }
                                
                            }
                            
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 100, height: 120)
                                    .background(Color(red: 0.03, green: 0.11, blue: 0.18))
                                    .cornerRadius(20)
                                VStack(spacing:0){
                                    Image("Debu")
                                    
                                    HStack(spacing:0){
                                        Text("950")
                                            .font(Font.system(size: 25, weight: .bold, design: .rounded))
                                            .foregroundColor(.lightWhite)
                                        
                                        Text("pts")
                                            .font(Font.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundColor(.lightWhite)
                                    }
                                }
                                
                            }
                            Spacer()
                        }
                        
                        VStack{
                            HStack{
                                Text("Leaderboard")
                                    .font(Font.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.darkBlack)
                                Spacer()
                                Button(action: {
                                    
                                }){
                                    HStack {
                                        Text("show more")
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
                                    .frame(width: 313, height: 283)
                                    .background(Color(red: 0.5, green: 0.79, blue: 0.77))
                                    .cornerRadius(20)
                                
                                
                                VStack(spacing: 4) {
                                    ListScore(number: "1", image: "ava1", name: "Rizky", description: "Grand Clean", score: "2350")
                                    ListScore(number: "2", image: "ava2", name: "Me", description: "Cleanaholic", score: "2350")
                                    ListScore(number: "3", image: "ava1", name: "Vicky", description: "Grand Clean", score: "2350")
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal, 50)
                    .tint(.softGreen)
                }
            }
            .padding(.bottom, 75)
            .navigationBarTitle("Hello Nisa")
        }
    }
}

struct ListScore: View {
    var number: String
    var image: String
    var name: String
    var description: String
    var score: String
    
    var body: some View {
        HStack {
            Text(number)
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
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                        Text(description)
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.lightWhite)
                        Text(score)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.softGreen)
                    }
                }
                .padding(.leading)
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}