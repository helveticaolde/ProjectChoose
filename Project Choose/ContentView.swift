//
//  ContentView.swift
//  Project Choose
//
//  Created by Felix Habib on 8/3/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var pchoose = PChoose()
    @State private var instructionsVisible = true
    
    var body: some View {
        ZStack (alignment: .top) {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // debug view
//                if (pchoose.round > 1) {
//                    InstructionText(text: "range: \(pchoose.range)")
//                    InstructionText(text: "history: \(pchoose.history[pchoose.round - 1])")
//                }
                // debug view
                if (instructionsVisible) {
                    HeadingView(pchoose: $pchoose)
                        .transition(.opacity)
//                        .transition(.asymmetric(insertion: .opacity, removal: .scale))
                } else {
                    RoundView(pchoose: $pchoose)
                        .transition(.opacity)
                }
                HStack (spacing: 0) {
                    RangeView(pchoose: $pchoose)
                    NumberText(text: " - 1")
//                    if (!pchoose.isTimerRunning) {
//                        NumberText(text: " - 1")
//                            .transition(.slide)
//                            .animation(.easeInOut(duration: 0.2), value: pchoose.isTimerRunning)
//                    }
                }
                .padding(.top, -6.0)
                
                // to remove
//                TimerRangeView(pchoose: $pchoose)
                // to remove
                
//                ChartViewManager(pchoose: $pchoose)
//                    .padding(.leading, -8.0)
//                    .padding(.trailing, 4.0)
                
                if (instructionsVisible) {
                    InstructionsView(pchoose: $pchoose)
                        .transition(.opacity)
//                        .transition(.asymmetric(insertion: .opacity, removal: .scale))
                } else {
                    ChartViewManager(pchoose: $pchoose)
                        .padding(.leading, -8.0)
                        .padding(.trailing, 4.0)
//                    ChartView(data: pchoose.historyDouble)
//                        .opacity(pchoose.isTimerRunning ? 0 : 1)
                    // Working graph from dependency
    //                GraphView(list: pchoose.historyDouble)
                }
                
                
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .padding()
            
            HStack {
                Spacer()
                RestartButton(pchoose: $pchoose, instructionsVisible: $instructionsVisible)
            }
            .frame(alignment: .topLeading)
            .padding()
            
            VStack {
                Spacer()
                if (!pchoose.finished && !pchoose.isTimerRunning) {
                    HitMeButton(pchoose: $pchoose, instructionsVisible: $instructionsVisible)
                }
            }
        }
        
    }
}

struct HeadingView: View {
    // dont need binding?
    @Binding var pchoose: PChoose
    
    var body: some View {
        InstructionText(text: "pick a number in range")
    }
    
}

struct RoundView: View {
    @Binding var pchoose: PChoose
    
    var body: some View {
        InstructionText(text: "round \(pchoose.round - 1)")
    }
}

struct InstructionsView: View {
    @Binding var pchoose: PChoose
    
    var body: some View {
        InstructionText(text: "each round, a number will be chosen between the previous result and 1")
            .padding()
        InstructionText(text: "if the number is 1 on your turn, you lose")
    }
    
}

struct HitMeButton: View {
    @Binding var pchoose: PChoose
    @Binding var instructionsVisible: Bool
    
    var body: some View {
        
        Button(action: {
            if (pchoose.round == 1) {
                withAnimation {
                    instructionsVisible = false
                }
            }
//            pchoose.prepNewRound()
            pchoose.startNewRound()
        }) {
            HStack {
                if (instructionsVisible) {
                    HelperText(text: "tap to play")
                        .padding(.horizontal, 10.0)
                }
                ButtonText(systemName: "chevron.forward")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .cornerRadius(12.0)
        }
    }
    
}

struct RestartButton: View {
    @Binding var pchoose: PChoose
    @Binding var instructionsVisible: Bool

    var body: some View {
        
        Button(action: {
            withAnimation {
                instructionsVisible = true
            }
            pchoose.restart()
        }) {
            RoundButtonText(systemName: "arrow.triangle.2.circlepath")
        }
        
    }

}

struct ChartViewManager: View {
    @Binding var pchoose: PChoose
    
    var body: some View {
        ChartView(data: pchoose.graphHistory)
            .opacity(pchoose.isTimerRunning ? 0.0 : 1.0)
//            .opacity((pchoose.isTimerRunning || pchoose.graphHistory.count == 0) ? 0.0 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: pchoose.isTimerRunning)
            .onChange(of: pchoose.isTimerRunning, perform: { _ in
                if (!pchoose.isTimerRunning) {
                    pchoose.updateGraphHistory()
                }
            })
        
//            .opacity(visibility)
//            .onChange(of: pchoose.isTime rRunning, perform: { _ in
//                if (visibility == 1) {
//                    DispatchQueue.main.asyncAfter(deadline: .now()) {
//                        withAnimation(.linear(duration: 0.2)) {
//                            visibility = 0
//                        }
//                    }
//                } else {
//                    DispatchQueue.main.asyncAfter(deadline: .now()) {
//                        pchoose.updateHistoryDouble()
//                        withAnimation(.linear(duration: 0.2)) {
//                            visibility = 1
//                        }
//                    }
//                }
//            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
