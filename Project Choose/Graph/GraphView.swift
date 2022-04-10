//
//  GraphView.swift
//  Project Choose
//
//  Created by Felix Habib on 27/3/2022.
//

import SwiftUI
import SwiftUICharts

struct GraphView: View {
    var list: [Double]
    let chartStyle = ChartStyle(backgroundColor: Color("BackgroundColor"), accentColor: Color("AccentColor"), gradientColor: GradientColor.init(start: Color.orange, end: Color.green), textColor: Color("TextColor"), legendTextColor: Color("TextColor"), dropShadowColor: Color.blue)

    
    var body: some View {
        LineView(data: list, style: chartStyle, valueSpecifier: "%.0f")
            .frame(maxHeight: 400)
            .padding()
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(list: [5000, 719, 394, 327, 140, 56, 14, 7, 5, 2, 1])
        GraphView(list: [5000, 719, 394, 327, 140, 56, 14, 7, 5, 2, 1])
            .preferredColorScheme(.dark)
    }
}
