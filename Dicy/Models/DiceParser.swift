//
//  DiceParser.swift
//  Dicy
//
//  Created by Pedro Simoes on 08/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import Foundation
class DiceParser:ObservableObject {
    
    @Published var results:String = ""
    
    func parseDice (fromString: String) {
        
        // Starting variables
        let diceFormula = fromString
        var resultString = diceFormula
        var diceToRoll:[String?] = []
        var detailedResultString = diceFormula
        
        // Setting up the regex
        let regexPattern = #"(\d+d\d+)"#
        let rangeOfString = NSRange(location: 0, length: diceFormula.utf16.count)
        let regex = try! NSRegularExpression(pattern: regexPattern, options: [])
        let matches = regex.matches(in: diceFormula, options: [], range: rangeOfString)
        
        print("Dice formula is \(diceFormula)")
        
        // Extracts the matches into their own strings
        for match in matches {
            // Note: the range is only 0 for this specific regex pattern. If you change the regex you're likely to need to change the range.
            let diceRange = match.range(at:0)
            let diceMatchRange = Range(diceRange, in:diceFormula)
            if diceMatchRange != nil {
                let dice = diceFormula[diceMatchRange!]
                diceToRoll.append(String(dice))
            }
            
            // Catches the matched strings and separates them into number of dice and number of sides on each dice
            for dice in diceToRoll {
                var numberOfDice:Int?
                var numberOfSides:Int?
                if dice != nil {
                    numberOfDice = Int(String((dice!.split(separator: "d").first)!))
                    numberOfSides = Int(String((dice!.split(separator: "d").last)!))
                    
                    // Actually rolls the dice, if there is any to be rolled
                    if numberOfDice != nil && numberOfSides != nil {
                        let dieRolls = rollDice(numberOfDice: numberOfDice!, sides: numberOfSides!)
                        // Creates a string with the detailed dice results
                        detailedResultString = detailedResultString.replacingOccurrences(of: dice!, with: "\(dieRolls)")
                        let resultSum = (dieRolls).reduce(0,+)
                        // Takes the original string and replaces each dice with their respective results
                        // TODO: Find a better way to replace the dice in the string, allowing for expressions like 1d6+1d6
                        resultString = resultString.replacingOccurrences(of: dice!, with: String(resultSum))
                    }
                }
            }
        }
        print("Detailed results are: \(detailedResultString)")
        if resultString != "" && resultString != diceFormula {
            let result = NSExpression(format: resultString)
            print("The result math expression is \(result)")
            results = "\(detailedResultString) = \(result.expressionValue(with: nil, context: nil)!)"
        } else if resultString != "" {
            results = "Dice syntax error"
        } else { results = "" }
    }
}
