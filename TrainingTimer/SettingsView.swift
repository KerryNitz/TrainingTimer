//
//  SettingsView.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 30/05/26.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("totalRounds") private var totalRounds: Int = 4
    @AppStorage("totalExercises") private var totalExercises: Int = 8
    @AppStorage("timeUnderTension") private var timeUnderTension: Int = 30
    @AppStorage("timeResting") private var timeResting: Int = 30
    @AppStorage("totalSets") private var totalSets: Int = 10
    @AppStorage("totalMinutes") private var totalMinutes: Int = 30
    @AppStorage("leadInTime") private var leadInTime: Int = 10
    
    @State private var textRounds: String = "4"
    @State private var textExercises: String = "8"
    @State private var textTUT: String = "30"
    @State private var textRest: String = "30"
    @State private var textSets: String = "10"
    @State private var textMinutes: String = "30"
    @State private var textLeadIn: String = "10"
    
    private let widthFactor: Double = 0.05
    private let paddingValue: CGFloat = 6.0
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimum = .init(integerLiteral: 1)
        formatter.maximum = .init(integerLiteral: Int.max)
        formatter.generatesDecimalNumbers = false
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    func retrieveValues() {
        textRounds = "\($totalRounds.wrappedValue)"
        textExercises = "\($totalExercises.wrappedValue)"
        textTUT = "\($timeUnderTension.wrappedValue)"
        textRest = "\($timeResting.wrappedValue)"
        textSets = "\($totalSets.wrappedValue)"
        textMinutes = "\($totalMinutes.wrappedValue)"
        textLeadIn = "\($leadInTime.wrappedValue)"
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: true) {
                VStack {
                    Text("General Settings")
                        .bold()
                        .padding(.all, paddingValue)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.clear)
                        .onAppear { retrieveValues() }
                    HStack {
                        Text("Lead-in Time (s):")
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                            .background(.clear)
                        TextField("Lead-in Time (s):", text: $textLeadIn)
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .keyboardType(.numberPad)
                            .onChange(of: textLeadIn) { oldValue, newValue in
                                // Remove anything that isn't a digit, and strip leading zeros
                                // Remove everything except numbers
                                let filtered = newValue.filter { $0.isNumber }
                                
                                // Prevent starting with 0 if you want strictly positive (1+)
                                if filtered.hasPrefix("0") {
                                    textLeadIn = String(filtered.dropFirst())
                                    return
                                }
                                
                                // Update text field safely
                                textLeadIn = filtered
                                
                                // 5. Save back to AppStorage if it's a valid number
                                if let integerValue = Int(filtered) {
                                    leadInTime = integerValue
                                }
                            }
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
                        TextField("Number of Sets:", text: $textSets)
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .keyboardType(.numberPad)
                            .onChange(of: textSets) { oldValue, newValue in
                                // Remove anything that isn't a digit, and strip leading zeros
                                // Remove everything except numbers
                                let filtered = newValue.filter { $0.isNumber }
                                
                                // Prevent starting with 0 if you want strictly positive (1+)
                                if filtered.hasPrefix("0") {
                                    textSets = String(filtered.dropFirst())
                                    return
                                }
                                
                                // Update text field safely
                                textSets = filtered
                                
                                // 5. Save back to AppStorage if it's a valid number
                                if let integerValue = Int(filtered) {
                                    totalSets = integerValue
                                }
                            }
                        Spacer(minLength: geo.size.width * 0.05)
                    }
                    Divider()
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
                        TextField("Number of Rounds:", text: $textRounds)
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .keyboardType(.numberPad)
                            .onChange(of: textRounds) { oldValue, newValue in
                                // Remove anything that isn't a digit, and strip leading zeros
                                // Remove everything except numbers
                                let filtered = newValue.filter { $0.isNumber }
                                
                                // Prevent starting with 0 if you want strictly positive (1+)
                                if filtered.hasPrefix("0") {
                                    textRounds = String(filtered.dropFirst())
                                    return
                                }
                                
                                // Update text field safely
                                textRounds = filtered
                                
                                // 5. Save back to AppStorage if it's a valid number
                                if let integerValue = Int(filtered) {
                                    totalRounds = integerValue
                                }
                            }
                        Spacer(minLength: geo.size.width * 0.05)
                    }
                    HStack {
                        Text("Number of Exercises:")
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                            .background(.clear)
                        TextField("Number of Exercises:", text: $textExercises)
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .keyboardType(.numberPad)
                            .onChange(of: textExercises) { oldValue, newValue in
                                // Remove anything that isn't a digit, and strip leading zeros
                                // Remove everything except numbers
                                let filtered = newValue.filter { $0.isNumber }
                                
                                // Prevent starting with 0 if you want strictly positive (1+)
                                if filtered.hasPrefix("0") {
                                    textExercises = String(filtered.dropFirst())
                                    return
                                }
                                
                                // Update text field safely
                                textExercises = filtered
                                
                                // 5. Save back to AppStorage if it's a valid number
                                if let integerValue = Int(filtered) {
                                    totalExercises = integerValue
                                }
                            }
                        Spacer(minLength: geo.size.width * 0.05)
                    }
                    HStack {
                        Text("Time under tension (s):")
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                            .background(.clear)
                        TextField("Time under tension (s):", text: $textTUT)
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .keyboardType(.numberPad)
                            .onChange(of: textTUT) { oldValue, newValue in
                                // Remove anything that isn't a digit, and strip leading zeros
                                // Remove everything except numbers
                                let filtered = newValue.filter { $0.isNumber }
                                
                                // Prevent starting with 0 if you want strictly positive (1+)
                                if filtered.hasPrefix("0") {
                                    textTUT = String(filtered.dropFirst())
                                    return
                                }
                                
                                // Update text field safely
                                textTUT = filtered
                                
                                // 5. Save back to AppStorage if it's a valid number
                                if let integerValue = Int(filtered) {
                                    timeUnderTension = integerValue
                                }
                            }
                        Spacer(minLength: geo.size.width * 0.05)
                    }
                    HStack {
                        Text("Time resting (s):")
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.7, alignment: Alignment.trailing)
                            .background(.clear)
                        TextField("Time resting (s):", text: $textRest)
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .keyboardType(.numberPad)
                            .onChange(of: textRest) { oldValue, newValue in
                                // Remove anything that isn't a digit, and strip leading zeros
                                // Remove everything except numbers
                                let filtered = newValue.filter { $0.isNumber }
                                
                                // Prevent starting with 0 if you want strictly positive (1+)
                                if filtered.hasPrefix("0") {
                                    textRest = String(filtered.dropFirst())
                                    return
                                }
                                
                                // Update text field safely
                                textRest = filtered
                                
                                // 5. Save back to AppStorage if it's a valid number
                                if let integerValue = Int(filtered) {
                                    timeResting = integerValue
                                }
                            }
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
                        TextField("Number of Minutes:", text: $textMinutes)
                            .padding(.all, paddingValue)
                            .frame(width: geo.size.width * 0.2, alignment: Alignment.trailing)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .keyboardType(.numberPad)
                            .onChange(of: textMinutes) { oldValue, newValue in
                                // Remove anything that isn't a digit, and strip leading zeros
                                // Remove everything except numbers
                                let filtered = newValue.filter { $0.isNumber }
                                
                                // Prevent starting with 0 if you want strictly positive (1+)
                                if filtered.hasPrefix("0") {
                                    textMinutes = String(filtered.dropFirst())
                                    return
                                }
                                
                                // Update text field safely
                                textMinutes = filtered
                                
                                // 5. Save back to AppStorage if it's a valid number
                                if let integerValue = Int(filtered) {
                                    totalMinutes = integerValue
                                }
                            }
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
