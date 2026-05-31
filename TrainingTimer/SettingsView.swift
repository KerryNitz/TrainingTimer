//
//  SettingsView.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 30/05/26.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("totalRounds") private var totalRounds = "4"
    @AppStorage("totalExercises") private var totalExercises = "8"
    @AppStorage("timeUnderTension") private var timeUnderTension = "30"
    @AppStorage("timeResting") private var timeResting = "30"
    @AppStorage("totalSets") private var totalSets = "10"
    
    private let widthFactor: Double = 0.02
    private let paddingValue: CGFloat = 6.0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Custom TUT Settings")
                    .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                    .bold()
                    .padding(.all, paddingValue)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.clear)
                HStack {
                    Text("Number of Rounds:")
                        .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                        .padding(.all, paddingValue)
                        .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                        .background(.clear)
                    TextField("Number of Rounds:", text: $totalRounds)
                        .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                        .padding(.all, paddingValue)
                        .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    Spacer(minLength: geo.size.width * 0.05)
                }
                HStack {
                    Text("Number of Exercises:")
                        .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                        .padding(.all, paddingValue)
                        .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                        .background(.clear)
                    TextField("Number of Exercises:", text: $totalExercises)
                        .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                        .padding(.all, paddingValue)
                        .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    Spacer(minLength: geo.size.width * 0.05)
                }
                HStack {
                    Text("Time under tension (s):")
                        .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                        .padding(.all, paddingValue)
                        .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                        .background(.clear)
                    TextField("Time under tension (s):", text: $timeUnderTension)
                        .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                        .padding(.all, paddingValue)
                        .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    Spacer(minLength: geo.size.width * 0.05)
                }
                HStack {
                    Text("Time resting (s):")
                        .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                        .padding(.all, paddingValue)
                        .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                        .background(.clear)
                    TextField("Time resting (s):", text: $timeResting)
                        .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                        .padding(.all, paddingValue)
                        .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    Spacer(minLength: geo.size.width * 0.05)
                }
                Text("Standard TUT Settings")
                    .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                    .bold()
                    .padding(.all, paddingValue)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.clear)
                HStack {
                    Text("Number of Sets:")
                        .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                        .padding(.all, paddingValue)
                        .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                        .background(.clear)
                    TextField("Number of Sets:", text: $totalSets)
                        .font(.system(size: geo.size.width > geo.size.height ? geo.size.width * widthFactor : geo.size.width * widthFactor * 2))
                        .padding(.all, paddingValue)
                        .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    Spacer(minLength: geo.size.width * 0.05)
                }
                
            }
        }
    }
}

#Preview {
    SettingsView()
}
