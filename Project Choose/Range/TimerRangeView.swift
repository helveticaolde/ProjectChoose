//
//  TimerRangeView.swift
//  Project Choose
//
//  Created by Felix Habib on 9/4/2022.
//

import SwiftUI

struct TimerRangeView: View {
    @Binding var pchoose: PChoose
    @State private var timeRemaining = Constants.maxRange
//    private var nextNum = Constants.maxRange
    
    var body: some View {
        NumberText(text: "\(timeRemaining)")
            .onChange(of: pchoose.round, perform: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.linear(duration: 0.8)) {
                        timeRemaining = pchoose.range
                    }
                }
            })
    }
}

struct TimerRangeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
