//
//  DiceRollers.swift
//  Dicy
//
//  Created by Pedro Simoes on 08/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import Foundation

// Rolls regular dice such as d6, d10 and d20 and gives the results back as an array
func rollDice (numberOfDice:Int, sides:Int) -> [Int] {
    var results:[Int] = []
    for _ in 1...abs(numberOfDice) {
        let dieRoll = Int.random(in: 1...sides)
        if numberOfDice < 0 {
            results.append(-dieRoll)
        } else {
            results.append(dieRoll)
        }
    }
        return results
}
