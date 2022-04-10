//
//  ChartView.swift
//  Project Choose
//
//  Created by Felix Habib on 28/3/2022.

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    
    var data: [Double]
    private let maxY: Double = Double(Constants.maxRange)
    private let minY: Double = 0
//    @State private var percentage: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 0) {
                HStack (spacing: 0) {
                    chartYAxis
                        .frame(width: 40)
                    chartView
                }
                HStack (spacing: 0) {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 40, height: 20)
                    chartXAxis
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.4)
            .font(.caption)
            .foregroundColor(Color("TextColor"))
//            .onChange(of: data.count, perform: { _ in
//                percentage = 0
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    withAnimation(.linear(duration: 0.8)) {
//                        percentage = 1.0
//                    }
//                }
//        })
        }
        .frame(maxHeight: UIScreen.main.bounds.height * 0.45)
        
    }
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            ZStack {
                // Shaded area beneath line
                Path { path in
                    for index in data.indices {

                        let xPosition = geometry.size.width / CGFloat(data.count - 1) * CGFloat(index)

                        let yAxis = maxY - minY
                        let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height

                        if (index == 0) {
                            path.move(to: CGPoint(x: xPosition, y: yPosition))
                        }
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition ))
                    }

                    let yBottom = (1 - CGFloat((0 - minY) / maxY - minY)) * geometry.size.height
                    let xRight = geometry.size.width
                    path.addLine(to: CGPoint(x: xRight, y: yBottom))
                    path.addLine(to: CGPoint(x: 0, y: yBottom))
                }
                .fill(Color("AccentColor"))
                .opacity(0.5)
                .clipped()
                
                chartBackground
                
                // Stroke Line
                Path { path in
                    for index in data.indices {
                        
                        let xPosition = geometry.size.width / CGFloat(data.count - 1) * CGFloat(index)
                        
                        let yAxis = maxY - minY
                        let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                        
                        if (index == 0) {
                            path.move(to: CGPoint(x: xPosition, y: yPosition))
                        }
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition ))
                    }
                }
//                .trim(from: 0, to: percentage)
                .stroke(
                    Color("AccentColor"),
                    style: StrokeStyle(
                        lineWidth: 3,
                        lineCap: .round,
                        lineJoin: .round))
                .clipped()
            }
            
        }
        
        
    }
    
    private var horizontalDivider: some View {
        Divider().frame(height: 0.5).opacity(0).background(Color("DividerColor"))
    }
    
    private var verticalDivider: some View {
        Divider().frame(width: 0.6).opacity(0).background(Color("DividerColor"))
    }
    
    private var chartBackground: some View {
        ZStack {
            HStack {
                verticalDivider
                Spacer()
                verticalDivider
            }
            VStack {
                horizontalDivider
                Spacer()
                horizontalDivider
                Spacer()
                horizontalDivider
            }
        }
    }
    
    private var chartYAxis: some View {
        VStack (alignment: .trailing) {
            AxisText(num: maxY)
            Spacer()
            let midY = (maxY + minY) / 2
            AxisText(num: midY)
            Spacer()
            AxisText(num: minY)
        }
    }
    
    private var chartXAxis: some View {
        HStack {
            ForEach(0..<data.count, id: \.self) { index in
                AxisText(num: Double(index))
                if (index < (data.count - 1)) {
                    Spacer()
                }
            }
        }
    }
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(data: [5000, 4000, 3000, 719, 394, 327, 140, 56, 14, 7, 5, 2, 1])
        ChartView(data: [5000, 4000, 3000, 719, 394, 327, 140, 56, 14, 7, 5, 2, 1])
            .preferredColorScheme(.dark)
    }
}
