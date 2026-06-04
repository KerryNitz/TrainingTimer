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
    @AppStorage("totalMinutes") private var totalMinutes = "30"
    
    private let widthFactor: Double = 0.05
    private let paddingValue: CGFloat = 6.0
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: true) {
                VStack {
                    Text("Custom TUT Settings")
                        .bold()
                        .padding(.all, paddingValue)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.clear)
                    HStack {
                        Text("Number of Rounds:")
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                            .background(.clear)
                        TextField("Number of Rounds:", text: $totalRounds)
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
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                            .background(.clear)
                        TextField("Number of Exercises:", text: $totalExercises)
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
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                            .background(.clear)
                        TextField("Time under tension (s):", text: $timeUnderTension)
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
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                            .background(.clear)
                        TextField("Time resting (s):", text: $timeResting)
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
                    Divider()
                    Text("Standard TUT Settings")
                        .bold()
                        .padding(.all, paddingValue)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.clear)
                    HStack {
                        Text("Number of Sets:")
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                            .background(.clear)
                        TextField("Number of Sets:", text: $totalSets)
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
                    Divider()
                    Text("Custom EMOM Settings")
                        .bold()
                        .padding(.all, paddingValue)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.clear)
                    HStack {
                        Text("Number of Minutes:")
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                            .background(.clear)
                        TextField("Number of Minutes:", text: $totalMinutes)
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
                .font(.system(size: geo.size.width * widthFactor))
            }
        }
    }
}

#Preview {
    SettingsView()
}
