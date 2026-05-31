//
//  TUTView.swift
//  TrainingTimer
//
//  Created by Kerry Nitz on 30/05/26.
//

import SwiftUI

struct TUTView: View {
    @StateObject private var vm = TUTViewModel()
    @AppStorage("totalSets") private var totalSets = "10"
    
    let activeTime: Int
    let restTime: Int
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
                        .onAppear { vm.setData(Int($totalSets.wrappedValue) ?? 0, activeTime: activeTime, restTime: restTime)
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
        }
        .onReceive(timer) { _ in
            vm.updateLeadIn()
            vm.updateCountdown()
        }
        
    }
}

struct TUTView_Previews: PreviewProvider {
    static var previews: some View {
        TUTView(activeTime: 30, restTime: 30)
    }
}
