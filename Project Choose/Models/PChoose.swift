//
//  PChoose.swift
//  Project Choose
//
//  Created by Felix Habib on 8/3/2022.
//

import Foundation

struct PChoose {
    var target = 1 // make function for finished, if range = target
    var range = Constants.maxRange
    var round = 1
    var history: [Double] = [Double(Constants.maxRange)] // Fix this // maybe only use doubles?
    var graphHistory: [Double] = [Double(Constants.maxRange), 1]
    var finished = false // make sure to use this
    var isTimerRunning = false

    mutating func startNewRound() {
        round += 1
        range = Int.random(in: 1...(range-1))
        history.append(Double(range))
        if (range == 1) {
            finished = true
        }
    }
    
    mutating func updateGraphHistory() {
        graphHistory = history
    }
    
    mutating func restart() {
        round = 1
        range = Constants.maxRange
        history = [Double(Constants.maxRange)]
//        updateGraphHistory()
        graphHistory = [Double(Constants.maxRange), 1]
        finished = false
    }
    
    // Helpers
    func getDivisor() -> (Int, Int, Int, Int)? {
        var q: Int = 0
        var r: Int = 0
        var prev: Int = 0
        var curr: Int = 0
        if (round > 1) {
            prev = Int(history[round - 2])
            curr = Int(history[round - 1])
            let d: Int = prev - curr
            (q, r) = d.quotientAndRemainder(dividingBy: 120)
            return (prev, curr, q, r)
        }
        return nil
    }
    
}
