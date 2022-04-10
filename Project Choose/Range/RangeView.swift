//
//  RangeView.swift
//  Project Choose
//
//  Created by Felix Habib on 24/3/2022.
//

import SwiftUI

struct RangeView: View {
    @Binding var pchoose: PChoose
    @State private var timeRemaining = Constants.maxRange
    @State private var timer = Timer.publish(every: 1, tolerance: 0.1, on: .main, in: .common).autoconnect()
    @State private var prev = 0
    @State private var curr = 0
    @State private var q = 0 // Quotient
    @State private var r = 0 // remainder
    @State private var random = 0
    

    var body: some View {
        NumberText(text: "\(timeRemaining)")
            .onReceive(timer) { _ in
                // What happens when timer is running
                if pchoose.isTimerRunning {
                    // If not at range, decrease
                    if (timeRemaining > pchoose.range) {
                        if (timeRemaining <= 120 || q == 0) {
                            if (random%2 == 0) {
                                timeRemaining -= 1
                            } else if (timeRemaining <= 60) {
                                if (random%5 == 0) {
                                    timeRemaining -= 1
                                }
                            } else if (timeRemaining <= 10) {
                                if (random%8 == 0) {
                                    timeRemaining -= 1
                                }
                            }
                            random += 1
                        } else if (timeRemaining == prev && r != 0) {
                            timeRemaining -= r
                        } else {
                            timeRemaining -= q
                        }
                        
                    // If at range, stop timer
                    } else {
                        self.toggleTimer()
//                        pchoose.startNewRound()
                    }
                }
            }
            .onChange(of: pchoose.round, perform: { _ in
                if (pchoose.round == 1) {
                    self.resetTimer()
                } else {
                    self.toggleTimer()
                }
            })
            .onAppear() {
                self.stopTimer()
        }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
//        if (pchoose.history[pchoose.round - 1] > pchoose.range) {
//            pchoose.startNewRound()
//        }
    }
    
    func startTimer() {
        (prev, curr, q, r) = pchoose.getDivisor() ?? (-1, -1, -1, -1)
//        while (timeRemaining > 120 && q != 0 && q%10 == 0) {
        while (q%10 == 0 && q != 0) { // potential bug?
            timeRemaining += 1
            (prev, curr, q, r) = pchoose.getDivisor() ?? (-1, -1, -1, -1)
        }
        self.timer = Timer.publish(every: 0.01, tolerance: 0.1, on: .main, in: .common).autoconnect()
    }
    
    func resetTimer() {
        timeRemaining = Constants.maxRange
    }
    
    func toggleTimer() {
        if pchoose.isTimerRunning {
            // stop UI updates
            self.stopTimer()
        } else {
            // start UI updates
            self.startTimer()
        }
        pchoose.isTimerRunning.toggle()
    }
}

//struct RandomNumView: View {
//
//    var body: some View {
//        NumberText(text: "\(range) and 1")
//            .padding(.leading)
//    }
//}

//struct RowView: View {
//    let round: Int
//    let range: Int
//
//    var body: some View {
//        HStack {
//            NumberText(text: "\(range) and 1")
//                .padding(.leading)
//            Spacer()
//            RoundedTextView(text: String(round))
//        }
//    }
//}

struct RangeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }

}
