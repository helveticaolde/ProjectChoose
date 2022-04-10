//
//  PChoose.swift
//  Project Choose
//
//  Created by Felix Habib on 8/3/2022.
//

import Foundation

struct NumEntry { // remove
    let numid: Int // round
    let num: Int // range
}

struct PChoose {
    var target = 1
    var range = Constants.maxRange
    var round = 1
    var numEntries: [NumEntry] = [NumEntry(numid: 1, num: Constants.maxRange)] // remove
    var history: [Int] = [Constants.maxRange]
    var historyDouble: [Double] = [Double(Constants.maxRange)] // Fix this // maybe only use doubles?
    var finished = false
    var isTimerRunning = false
    
    var graphHistory: [Double] = [Double(Constants.maxRange)]
//    var graphHistory: [Double] = []
    

    mutating func startNewRound() {
        round += 1
        range = Int.random(in: 1...(range-1))
        numEntries.append(NumEntry(numid: round, num: range)) // remove
        history.append(range)
        historyDouble.append(Double(range))
        if (range == 1) {
            finished = true
        }
    }
    
    mutating func updateGraphHistory() {
//        historyDouble.append(Double(range))
        graphHistory.removeAll()
        graphHistory.append(contentsOf: historyDouble)
    }
    
    mutating func restart() {
        round = 1
        range = Constants.maxRange
        numEntries.removeAll()
        numEntries.append(NumEntry(numid: 1, num: Constants.maxRange))
        history = [Constants.maxRange]
        historyDouble = [Double(Constants.maxRange)]
//        history.append()
        updateGraphHistory()
//        graphHistory.removeAll()
        finished = false
    }
    
    // Helpers
    
    func getDivisor() -> (Int, Int, Int, Int)? {
        var q: Int = 0
        var r: Int = 0
        var prev: Int = 0
        var curr: Int = 0
        if (round > 1) {
            prev = history[round - 2]
            curr = history[round - 1]
            let d: Int = prev - curr
            (q, r) = d.quotientAndRemainder(dividingBy: 120)
            return (prev, curr, q, r)
        }
        return nil
    }
    
    func getUsedRange() -> Int {
        return Constants.maxRange - range
    }
}
