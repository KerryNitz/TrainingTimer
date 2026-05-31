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
    
    private let width: Double = 150
    private let inputWidth: Double = 75
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.headline)
                .padding()
                .frame(width: width)
                .background(.clear)
            HStack {
                Text("Number of Rounds:")
                    .font(.headline)
                    .padding()
                    .frame(width: width, alignment: Alignment.trailing)
                    .background(.clear)
                TextField("Number of Rounds:", text: $totalRounds)
                    .font(.headline)
                    .padding()
                    .frame(width: inputWidth, alignment: Alignment.trailing)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4)
                        )
            }
            HStack {
                Text("Number of Exercises:")
                    .font(.headline)
                    .padding()
                    .frame(width: width, alignment: Alignment.trailing)
                    .background(.clear)
                TextField("Number of Exercises:", text: $totalExercises)
                    .font(.headline)
                    .padding()
                    .frame(width: inputWidth, alignment: Alignment.trailing)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4)
                        )
            }
            HStack {
                Text("Time under tension (s):")
                    .font(.headline)
                    .padding()
                    .frame(width: width, alignment: Alignment.trailing)
                    .background(.clear)
                TextField("Time under tension (s):", text: $timeUnderTension)
                    .font(.headline)
                    .padding()
                    .frame(width: inputWidth, alignment: Alignment.trailing)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4)
                        )
            }
            HStack {
                Text("Time resting (s):")
                    .font(.headline)
                    .padding()
                    .frame(width: width, alignment: Alignment.trailing)
                    .background(.clear)
                TextField("Time resting (s):", text: $timeResting)
                    .font(.headline)
                    .padding()
                    .frame(width: inputWidth, alignment: Alignment.trailing)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4)
                        )
            }
        }
    }
}

#Preview {
    SettingsView()
}
