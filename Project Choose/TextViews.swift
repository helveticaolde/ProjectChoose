//
//  TextViews.swift
//  Project Choose
//
//  Created by Felix Habib on 10/3/2022.
//

import SwiftUI

struct TextView: View {
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    RoundButtonText(systemName: "arrow.triangle.2.circlepath")
                }
                InstructionText(text: "pick a number in range")
                    
                NumberText(text: "5000 - 1")
                    .padding(.top, -6.0)
                ChartView(data: [5000, 4000, 3000, 719, 394, 327, 140, 56, 14, 7, 5, 2, 1])
                HStack {
                    HelperText(text: "tap to play")
                        .padding(.horizontal, 10.0)
                    ButtonText(systemName: "chevron.forward")
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(12.0)
            }
            .padding()
        }
    }
}

struct HelperText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.custom(FontsManager.RobotoMono.regular, size: 28, relativeTo: .title))
//            .kerning(2.0)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .foregroundColor(Color("ButtonColor"))
            
    }
}


struct InstructionText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.custom(FontsManager.RobotoMono.regular, size: 20, relativeTo: .title3))
//            .kerning(2.0)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .foregroundColor(Color("TextColor"))
            
    }
}

struct NumberText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.custom(FontsManager.RobotoMono.regular, size: 45, relativeTo: .largeTitle))
            .fontWeight(.regular)
            .foregroundColor(Color("AccentColor"))
//            .kerning(2.0)
    }
}

struct AxisText: View {
    var num: Double
    
    var body: some View {
        let formatNum: String = String(format: "%.0f", num)
        Text(formatNum)
            .font(.custom(FontsManager.RobotoMono.regular, size: 12, relativeTo: .caption))
            .foregroundColor(Color("TextColor"))
    }
}

struct ButtonText: View {
    var systemName: String
    
    var body: some View {
        Image(systemName: systemName)
            .font(.largeTitle.weight(.semibold))
            .foregroundColor(Color("ButtonColor"))
    }
    
}

struct RoundButtonText: View {
    var systemName: String
    
    var body: some View {
        Image(systemName: systemName)
            .font(.title.weight(.heavy))
            .foregroundColor(Color("ButtonColor"))
            .frame(width: 56.0, height: 56.0
            )
    }
}

struct Space: View {
    
    var body: some View {
        Rectangle()
            .frame(height: 100)
            .foregroundColor(Color.black.opacity(0))
        
    }
}

struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
        TextView()
            .preferredColorScheme(.dark)
    }
}
