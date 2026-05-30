//
//  Content-ViewModel.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 28/05/26. Based on https://github.com/indently/CustomCountdownTimer/tree/main/CustomCountdownTimer.xcodeproj
//

import Foundation
import AudioToolbox

extension ContentView {
    final class ContentViewModel: ObservableObject {
        @Published var isActive = false
        @Published var showingAlert = false
        @Published var time: String = "5:00"
        @Published var minutes: Float = 5.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        private var initialTime = 0
        private var endDate = Date()
        
        // Start the timer with the given amount of minutes
        func start(minutes: Float) {
            self.initialTime = Int(minutes)
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
        }
        
        // Reset the timer
        func reset() {
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(minutes)):00"
        }
        
        // Show updates of the timer
        func updateCountdown(){
            guard isActive else { return }
            
            // Apple System Sound ID for a standard beep/alert (ID 1057 or 1000)
            let almostSoundID: SystemSoundID = 1013
            
            // Gets the current date and makes the time difference calculation
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            // Checks that the countdown is not <= 0
            if diff <= 0 {
                self.isActive = false
                self.time = "0:00"
                self.showingAlert = true
                return
            }
            
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
