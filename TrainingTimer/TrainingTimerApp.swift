//
//  TrainingTimerApp.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 28/05/26.
//

import SwiftUI

@main
struct TrainingTimerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                EMOMView(totalSets: 10)
                    .tabItem {
                        Label("EMOM10", systemImage: "clock")
                    }
                EMOMView(totalSets: 20)
                    .tabItem {
                        Label("EMOM20", systemImage: "clock")
                    }
                TUTView(activeTime: 30, restTime: 30)
                    .tabItem {
                        Label("TUT30/30", systemImage: "clock")
                    }
                TUTView(activeTime: 60, restTime: 60)
                    .tabItem {
                        Label("TUT60/60", systemImage: "clock")
                    }
                TUTView(activeTime: 90, restTime: 30)
                    .tabItem {
                        Label("TUT90/30", systemImage: "clock")
                    }
                CustomTUTView()
                    .tabItem {
                        Label("Custom TUT", systemImage: "clock")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
