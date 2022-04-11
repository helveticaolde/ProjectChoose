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
    @State private var graphVisible = false
    
    var body: some View {
        ZStack (alignment: .top) {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if (instructionsVisible) {
                    HeadingView()
                        .transition(.opacity)
                } else {
                    RoundView(pchoose: $pchoose)
                        .transition(.opacity)
                }
                HStack (spacing: 0) {
                    RangeView(pchoose: $pchoose)
                    NumberText(text: " - 1")
                }
                .padding(.top, -6.0)
                
                if (instructionsVisible) {
                    InstructionsView()
                        .transition(.opacity)
                } else {
                    ChartViewManager(pchoose: $pchoose, graphVisible: $graphVisible)
                        .padding(.leading, -8.0)
                        .padding(.trailing, 4.0)
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
//                if (!pchoose.finished && !pchoose.isTimerRunning) {
                if (!pchoose.isTimerRunning) {
                    HitMeButton(pchoose: $pchoose, instructionsVisible: $instructionsVisible)
                }
//                else if (pchoose.finished) {
//                    FinishedView()
//                        .transition(.opacity)
//                }
            }
        }
        
    }
}

struct FinishedView: View {
    
    var body: some View {
        HelperText(text: "game over")
    }
}

struct HeadingView: View {
    
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
    
    var body: some View {
        InstructionText(text: "each round, a number will be chosen between the previous result and 1")
            .padding()
        InstructionText(text: "if the number is 1 on your turn, you lose")
    }
    
}

struct HitMeButton: View {
    @Binding var pchoose: PChoose
    @Binding var instructionsVisible: Bool
//    @Binding var graphVisible: Bool
    
    var body: some View {
        
        Button(action: {
            if (pchoose.round == 1) {
                withAnimation(Animation.easeIn) {
                    instructionsVisible = false
                }
            }
            if (!pchoose.finished) {
                pchoose.startNewRound()
            }
        }) {
            HStack {
                if (instructionsVisible) {
                    HelperText(text: "tap to play")
                        .padding(.horizontal, 10.0)
                }
                if (!pchoose.finished) {
                    ButtonText(systemName: "chevron.forward")
                } else {
                    HelperText(text: "game over")
                }
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
    @Binding var graphVisible: Bool
    
    var body: some View {
        ChartView(data: pchoose.graphHistory)
            .opacity(graphVisible ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.40), value: graphVisible)
            .onChange(of: pchoose.isTimerRunning, perform: { _ in
                if (!pchoose.isTimerRunning) {
                    pchoose.updateGraphHistory()
                }
                if (pchoose.round > 0 && !pchoose.isTimerRunning) {
                    graphVisible = true
                } else {
                    graphVisible = false
                }
            })
    }
    
//    var body: some View {
//        ChartView(data: pchoose.graphHistory)
//            .opacity(pchoose.isTimerRunning ? 0.0 : 1.0)
//            .animation(.easeInOut(duration: 0.10), value: pchoose.isTimerRunning)
//            .onChange(of: pchoose.isTimerRunning, perform: { _ in
//                if (!pchoose.isTimerRunning) {
//                    pchoose.updateGraphHistory()
//                }
//            })
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
