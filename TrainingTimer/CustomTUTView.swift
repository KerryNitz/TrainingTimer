//
//  CustomTUTView.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 31/05/26.
//

import SwiftUI

struct CustomTUTView: View {
    @StateObject private var vm = CustomTUTViewModel()
    @AppStorage("totalRounds") private var totalRounds = "4"
    @AppStorage("totalExercises") private var totalExercises = "8"
    @AppStorage("timeUnderTension") private var timeUnderTension = "30"
    @AppStorage("timeResting") private var timeResting = "30"
    
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
                        .font(.system(size: geo.size.width * widthFactor))
                        .padding()
                        .frame(width: geo.size.width * 0.8, alignment: .center)
                        .background(.clear)
                    Spacer(minLength: geo.size.width * 0.1)
                }
                HStack {
                    Spacer(minLength: geo.size.width * 0.1)
                    Text("Sets to go: \(vm.setsToGo)")
                        .font(.system(size: geo.size.width * widthFactor))
                        .padding()
                        .frame(width: geo.size.width * 0.8, alignment: .center)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4)
                        )
                        .onAppear { vm.setData((Int($totalRounds.wrappedValue) ?? 0) * (Int($totalExercises.wrappedValue) ?? 0), activeTime: Int($timeUnderTension.wrappedValue) ?? 0, restTime: Int($timeResting.wrappedValue) ?? 0)
                        }
                    Spacer(minLength: geo.size.width * 0.1)
                }
                HStack {
                    Spacer(minLength: geo.size.width * 0.1)
                    Text("\(vm.time)")
                        .font(.system(size: geo.size.width * widthFactor))
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
                        vm.startSets(sets: vm.sets)
                    }
                    .disabled(vm.isActive)
                    .font(.system(size: geo.size.width * widthFactor))
                    
                    Button("Reset", action: vm.reset)
                        .tint(.red)
                        .font(.system(size: geo.size.width * widthFactor))
                }
                Spacer()
            }
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
