//
//  TimerView.swift
//  Project Choose
//
//  Created by Felix Habib on 22/3/2022.
//
/*
 full credit - https://stackoverflow.com/questions/63548432/swiftui-how-to-make-a-start-stop-timer
 */

import SwiftUI

struct TimerView: View {
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State private var timerString = "0.00"
    @State private var timeRemaining = 1000
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var shuffle = false

    var body: some View {

        VStack {
            Text("test + \(timeRemaining)")
                .font(Font.system(.largeTitle, design: .monospaced))
                .onReceive(timer) { _ in
                    if self.isTimerRunning {
                        if (timeRemaining > 0) {
                            timeRemaining -= 1
                        }
                    }
                }
                .onChange(of: shuffle, perform: { _ in
                    toggleTimer()
                })
                .onAppear() {
                    // no need for UI updates at startup
                    self.stopTimer()
                    if shuffle {
                        toggleTimer()
                    }
            }
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                shuffle.toggle()
            }
        }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
    
    func toggleTimer() {
        if isTimerRunning {
            // stop UI updates
            self.stopTimer()
        } else {
            timeRemaining = 1000
            startTime = Date()
            // start UI updates
            self.startTimer()
        }
        isTimerRunning.toggle()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
