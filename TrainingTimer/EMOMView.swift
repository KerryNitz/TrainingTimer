//
//  EMOMView.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 30/05/26.
//

import SwiftUI

struct EMOMView: View {
    @StateObject private var vm = EMOMViewModel()
    let totalSets: Int
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 600
    
    var body: some View {
        VStack {
            Text("Lead In: \(vm.leadIn)")
                .opacity(vm.isLeadingIn ? 1 : 0) // Hides text layout-neutrally if not leading in
                .animation(.default, value: vm.isLeadingIn)
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .padding()
                .frame(width: width)
                .background(.clear)
            Text("Sets to go: \(vm.setsToGo)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 4)
                    )
                .onAppear { vm.setData(totalSets)
                }
            Text("\(vm.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .alert("Finished!", isPresented: $vm.showingAlert) {
                    Button("Continue", role: .cancel) {
                        vm.reset()
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
            HStack(spacing:50) {
                Button("Start") {
                    vm.startSets(sets: vm.sets)
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

struct EMOMView_Previews: PreviewProvider {
    static var previews: some View {
        EMOMView(totalSets: 10)
    }
}
