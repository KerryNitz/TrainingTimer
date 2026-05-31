//
//  EMOMViewModel.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 30/05/26.
//

import Foundation
import AudioToolbox

extension EMOMView {
    final class EMOMViewModel: ObservableObject {
        @Published var isLeadingIn = false
        @Published var leadIn: String = "15"
        @Published var leadInSeconds: Int = 15
        @Published var setsToGo: String = "10"
        @Published var sets: Int = 10 {
            didSet {
                self.setsToGo = "\(sets)"
            }
        }
        @Published var isActive = false
        @Published var showingAlert = false
        @Published var time: String = "1:00"
        @Published var minutes: Float = 1.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        private var remainingSets: Int = 0
        private var initialTime = 0
        private var leadInTime = 0
        private var endDate = Date()
        
        func setData(_ totalSets: Int){
            self.sets = totalSets
            self.setsToGo = "\(totalSets)"
        }
        
        func startSets(sets: Int) {
            self.remainingSets = sets
            startLeadIn(seconds: leadInSeconds)
        }

        // Start the timer with the given amount of minutes
        func startLeadIn(seconds: Int) {
            self.leadInTime = seconds
            self.endDate = Date()
            self.isLeadingIn = true
            self.endDate = Calendar.current.date(byAdding: .second, value: seconds, to: endDate)!
        }

        // Start the timer with the given amount of minutes
        func start(minutes: Float) {
            self.initialTime = Int(minutes)
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
            self.time = "\(Int(minutes)):00"
        }
        
        // Reset the timer
        func reset() {
            self.leadInSeconds = leadInTime
            self.isLeadingIn = false
            self.leadIn = "\(leadInSeconds)"
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(minutes)):00"
            self.remainingSets = sets
            self.setsToGo = "\(sets)"
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
                start(minutes: minutes)
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
            guard isActive else { return }
            
            // Apple System Sound ID for a standard beep/alert (ID 1057 or 1000)
            let almostSoundID: SystemSoundID = 1200 //1200 is touch tone; 1013 is bell
            
            // Gets the current date and makes the time difference calculation
            let now = Date()
            
            // Checks that the countdown is not <= 0
            if endDate.timeIntervalSince1970 <= now.timeIntervalSince1970 {
                self.remainingSets -= 1
                self.setsToGo = "\(self.remainingSets)"
                if self.remainingSets > 0 {
                    self.minutes = Float(initialTime)
                    start(minutes: self.minutes)
                } else {
                    self.isActive = false
                    self.time = "0:00"
                    self.showingAlert = true
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
            self.minutes = Float(minutes)
            self.time = String(format:"%d:%02d", minutes, seconds)
            
            if diff <= 4 && diff >= 1 {
                AudioServicesPlaySystemSound(almostSoundID)
            }
        }
    }
}
