//
//  EMOMContentView.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 30/05/26.
//

import SwiftUI

struct EMOMContentView: View {
    @StateObject private var vm = EMOMViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 300
    
    var body: some View {
        VStack {
            Text("Lead In: \(vm.leadIn)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 4)
                    )
            Text("\(vm.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .alert("Timer done!", isPresented: $vm.showingAlert) {
                    Button("Continue", role: .cancel) {
                        // Code
                    }
                }
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 4)
                    )
            
            Slider(value: $vm.minutes, in: 1...10, step: 1)
                .padding()
                .disabled(vm.isActive)
                .animation(.easeInOut, value: vm.minutes)
                .frame(width: width)

            HStack(spacing:50) {
                Button("Start") {
                    vm.startLeadIn(seconds: vm.leadInSeconds)
                }
                .disabled(vm.isActive)
                
                Button("Reset", action: vm.reset)
                    .tint(.red)
            }
            .frame(width: width)
        }
        .onReceive(timer) { _ in
            vm.updateLeadIn()
            vm.updateCountdown()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EMOMContentView()
    }
}
