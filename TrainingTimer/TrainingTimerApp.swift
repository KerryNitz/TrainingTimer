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
                EMOMContentView()
                    .tabItem {
                        Label("EMOM10", systemImage: "clock")
                    }
                ContentView()
                    .tabItem {
                        Label("Timer", systemImage: "clock")
                    }
            }
        }
    }
}
