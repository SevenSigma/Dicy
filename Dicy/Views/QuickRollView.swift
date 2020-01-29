//
//  QuickRollButton.swift
//  Dicy
//
//  Created by Pedro Simoes on 28/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import SwiftUI

struct QuickRollView: View {
    
    let dicy:DicyController
    let parser:DiceParser
    
    var body: some View {
        
        VStack {
            HStack {
                QuickRollButton(dicy: dicy, parser: parser, sides: 4, image: "d4")
                QuickRollButton(dicy: dicy, parser: parser, sides: 6, image: "d6")
                QuickRollButton(dicy: dicy, parser: parser, sides: 8, image: "d8")
            }
            .buttonStyle(QuickRollButtonStyle())
            .padding(.leading)
            HStack {
                QuickRollButton(dicy: dicy, parser: parser, sides: 10, image: "d10")
                QuickRollButton(dicy: dicy, parser: parser, sides: 12, image: "d12")
                QuickRollButton(dicy: dicy, parser: parser, sides: 20, image: "d20")
            }
            .buttonStyle(QuickRollButtonStyle())
            .padding(.leading)
            
        }
    }
}

struct QuickRollButton: View {
    
    let dicy:DicyController
    let parser:DiceParser
    let sides:Int
    let image:String
    
    var body: some View {
        Button(action: {
            withAnimation(Animation.spring().speed(5)) {
                if self.dicy.addToggleIsPressed == true {
                    self.dicy.results.append(quickRollDice(sides: self.sides))
                } else {
                    self.dicy.results = [quickRollDice(sides: self.sides)]
                }
                self.dicy.isResultsEmpty = false
                self.parser.results = "\(self.dicy.results.description) = \(self.dicy.results.reduce(0,+))"
            }
            
        }) {
            Image(image)
        }
    }
}

struct QuickRollButtonStyle: ButtonStyle {
    public func makeBody(configuration: QuickRollButtonStyle.Configuration) -> some View {
        
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(Animation.spring().speed(5))
    }
}
