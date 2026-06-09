//
//  CustomTUTView.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 31/05/26.
//

import SwiftUI

struct CustomTUTView: View {
    @StateObject private var vm = CustomTUTViewModel()
    @AppStorage("totalRounds") private var totalRounds: Int = 4
    @AppStorage("totalExercises") private var totalExercises: Int = 8
    @AppStorage("timeUnderTension") private var timeUnderTension: Int = 30
    @AppStorage("timeResting") private var timeResting: Int = 30
    @AppStorage("leadInTime") private var leadInTime: Int = 10
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let widthFactor: Double = 0.05
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Text("Lead In: \(vm.leadIn)")
                        .opacity(vm.isLeadingIn ? 1 : 0) // Hides text layout-neutrally if not leading in
                        .animation(.default, value: vm.isLeadingIn)
                        .padding()
                        .frame(width: geo.size.width * 0.8, alignment: .center)
                        .background(.clear)
                    Spacer(minLength: geo.size.width * 0.1)
                }
                HStack {
                    Spacer(minLength: geo.size.width * 0.1)
                    Text("Rounds to go: \(vm.roundsToGo)")
                        .padding()
                        .frame(width: geo.size.width * 0.8, alignment: .center)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4)
                        )
                        .onAppear { vm.setData($totalRounds.wrappedValue * $totalExercises.wrappedValue, activeTime: $timeUnderTension.wrappedValue, restTime: $timeResting.wrappedValue, leadInTime: $leadInTime.wrappedValue)
                        }
                    Spacer(minLength: geo.size.width * 0.1)
                }
                HStack {
                    Spacer(minLength: geo.size.width * 0.1)
                    Text("\(vm.time)")
                        .alert("Finished!", isPresented: $vm.showingAlert) {
                            Button("Continue", role: .cancel) {
                                vm.reset()
                            }
                        }
                        .padding()
                        .frame(width: geo.size.width * 0.8, alignment: .center)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4)
                        )
                    Spacer(minLength: geo.size.width * 0.1)
                }
                HStack(spacing:50) {
                    Button("Start") {
                        vm.startRounds(rounds: vm.rounds)
                    }
                    .disabled(vm.isActive)
                    
                    Button("Reset", action: vm.reset)
                        .tint(.red)
                }
                Spacer()
            }
            .font(.system(size: geo.size.width * widthFactor))
            
            .onReceive(timer) { _ in
                vm.updateLeadIn()
                vm.updateCountdown()
            }
        }
    }
}

#Preview {
    CustomTUTView()
}
