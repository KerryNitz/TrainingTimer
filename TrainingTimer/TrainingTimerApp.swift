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
                EMOMContentView(totalSets: 10)
                    .tabItem {
                        Label("EMOM10", systemImage: "clock")
                    }
                EMOMContentView(totalSets: 20)
                    .tabItem {
                        Label("EMOM20", systemImage: "clock")
                    }
                TUTContentView(totalSets: 10, activeTime: 30, restTime: 30)
                    .tabItem {
                        Label("TUT3030", systemImage: "clock")
                    }
                TUTContentView(totalSets: 10, activeTime: 60, restTime: 60)
                    .tabItem {
                        Label("TUT6060", systemImage: "clock")
                    }
                TUTContentView(totalSets: 10, activeTime: 90, restTime: 30)
                    .tabItem {
                        Label("TUT9030", systemImage: "clock")
                    }
                ContentView()
                    .tabItem {
                        Label("Timer", systemImage: "clock")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
