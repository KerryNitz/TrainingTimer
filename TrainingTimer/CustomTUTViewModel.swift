//
//  CustomTUTViewModel.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 31/05/26.
//

import Foundation
import AudioToolbox

extension CustomTUTView {
    final class CustomTUTViewModel: ObservableObject {
        @Published var isLeadingIn = false
        @Published var leadIn: String = "15"
        @Published var leadInSeconds: Int = 15
        @Published var roundsToGo: String = "4"
        @Published var rounds: Int = 4 {
            didSet {
                self.roundsToGo = "\(rounds)"
            }
        }
        @Published var exercises: Int = 8
        @Published var exerciseNumber: String = "1"
        @Published var isActive = false
        @Published var showingAlert = false
        @Published var time: String = "Go for 30"
        @Published var seconds: Int = 30 {
            didSet {
                self.time = "Go for \(30)"
            }
        }
        @Published var isRest = false
        @Published var rest: Int = 30
        private var remainingRounds: Int = 0
        private var initialTime = 0
        private var initialRest = 0
        private var leadInTime = 0
        private var endDate = Date()
        private var exerciseCount: Int = 0
        
        func setData(_ totalRounds: Int, exercises:Int, activeTime: Int, restTime: Int, leadInTime: Int){
            self.rounds = totalRounds
            self.roundsToGo = "\(totalRounds)"
            self.exercises = exercises
            self.exerciseNumber = "1"
            self.seconds = activeTime
            self.time = "Go for \(activeTime)"
            self.rest = restTime
            self.leadInSeconds = leadInTime
            self.leadIn = "\(leadInTime)"
        }
        
        func startRounds(rounds: Int) {
            self.remainingRounds = rounds
            self.initialRest = rest
            exerciseCount += 1
            startLeadIn(seconds: leadInSeconds)
        }

        // Start the timer with the given amount of minutes
        func startLeadIn(seconds: Int) {
            self.leadInTime = seconds
            self.endDate = Date()
            self.isLeadingIn = true
            self.endDate = Calendar.current.date(byAdding: .second, value: seconds, to: endDate)!
            self.exerciseNumber = "\(Int(exerciseCount)) is next"
        }

        // Start the timer with the given amount of minutes
        func start(seconds: Int) {
            self.initialTime = seconds
            self.endDate = Date()
            self.isActive = true
            self.isRest = false
            self.endDate = Calendar.current.date(byAdding: .second, value: seconds, to: endDate)!
            self.time = "Go for \(seconds)"
            self.exerciseNumber = "\(Int(exerciseCount))"
        }
        
        func startRest(seconds: Int) {
            self.initialRest = seconds
            self.endDate = Date()
            self.isActive = false
            self.isRest = true
            self.endDate = Calendar.current.date(byAdding: .second, value: seconds, to: endDate)!
            self.time = "Resting for \(seconds)"
            if exerciseCount == self.exercises {
                exerciseCount = 1
            } else {
                exerciseCount += 1
            }
            self.exerciseNumber = "\(Int(exerciseCount)) is next"
        }
        
        // Reset the timer
        func reset() {
            self.leadInSeconds = leadInTime
            self.isLeadingIn = false
            self.leadIn = "\(leadInSeconds)"
            self.seconds = initialTime
            self.rest = initialRest
            self.isActive = false
            self.isRest = false
            self.time = "\(seconds)"
            self.remainingRounds = rounds
            self.roundsToGo = "\(rounds)"
            self.exerciseNumber = "1"
        }
        
        
        // Show updates of the timer
        func updateLeadIn(){
            guard isLeadingIn else { return }
            
            // Apple System Sound ID for a standard beep/alert (ID 1057 or 1000)
            let almostSoundID: SystemSoundID = 1200 //1200 is touch tone; 1013 is bell
            
            // Gets the current date and makes the time difference calculation
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            // Checks that the countdown is not <= 0
            if diff <= 0 {
                self.isLeadingIn = false
                self.leadIn = "\(leadInSeconds)"
                start(seconds: seconds)
                return
            }
            
            // Turns the time difference calculation into sensible data and formats it
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date) + minutes * 60

            // Updates the time string with the formatted time
            self.leadInSeconds = seconds
            self.leadIn = "\(seconds)"
            
            if diff <= 4 && diff >= 1 {
                AudioServicesPlaySystemSound(almostSoundID)
            }
        }
        
        // Show updates of the timer
        func updateCountdown(){
            guard isActive || isRest else { return }
            
            // Apple System Sound ID for a standard beep/alert (ID 1057 or 1000)
            let almostSoundID: SystemSoundID = 1200 //1200 is touch tone; 1013 is bell
            
            // Gets the current date and makes the time difference calculation
            let now = Date()
            
            // Checks that the countdown is not <= 0
            if endDate.timeIntervalSince1970 <= now.timeIntervalSince1970 {
                if self.isRest && exerciseCount == 1 {
                    self.remainingRounds -= 1
                    self.roundsToGo = "\(self.remainingRounds)"
                }
                if self.remainingRounds > 0 {
                    if self.isActive {
                        self.seconds = initialRest
                        if self.remainingRounds == 1 && self.exerciseCount == self.exercises {
                            self.isActive = false
                            self.isRest = false
                            self.time = "Go for 0"
                            self.showingAlert = true
                            self.exerciseNumber = "1"
                            return
                        }
                        startRest(seconds: self.seconds)
                    } else if self.isRest {
                        self.seconds = initialTime
                        start(seconds: self.seconds)
                    }
                } else {
                    self.isActive = false
                    self.isRest = false
                    self.time = "Go for 0"
                    self.showingAlert = true
                    self.exerciseNumber = "1"
                    return
                }
            }
            
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            // Turns the time difference calculation into sensible data and formats it
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)

            // Updates the time string with the formatted time
            self.seconds = seconds + 60 * minutes
            if isActive {
                self.time = "Go for \(self.seconds)"
            } else if isRest {
                self.time = "Rest for \(self.seconds)"
            }
            if diff <= 4 && diff >= 1 {
                AudioServicesPlaySystemSound(almostSoundID)
            }
        }
    }
}
