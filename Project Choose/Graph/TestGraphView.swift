//
//  TestGraphView.swift
//  Project Choose
//
//  Created by Felix Habib on 28/3/2022.
//

import SwiftUI
import SwiftUICharts

struct TestGraphView: View {
    var body: some View {
        LineView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Full screen")
    }
}

struct TestGraphView_Previews: PreviewProvider {
    static var previews: some View {
        TestGraphView()
    }
}
