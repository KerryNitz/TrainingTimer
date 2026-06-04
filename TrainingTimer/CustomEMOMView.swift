//
//  CustomEMOMView.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 4/06/26.
//

import SwiftUI


struct CustomEMOMView: View {
    @StateObject private var vm = CustomEMOMViewModel()
    @AppStorage("totalMinutes") private var totalMinutes = "30"
    @AppStorage("leadInTime") private var leadInTime = "10"
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let widthFactor: Double = 0.05
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Spacer(minLength: geo.size.width * 0.1)
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
                    Text("Minutes to go: \(vm.setsToGo)")
                        .padding()
                        .frame(width: geo.size.width * 0.8, alignment: .center)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4)
                        )
                        .onAppear {
                            vm.setData(Int($totalMinutes.wrappedValue) ?? 0, leadInTime: Int($leadInTime.wrappedValue) ?? 0)
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
                        .frame(width: geo.size.width * 0.8)
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
    EMOMView(totalSets: 30)
}
