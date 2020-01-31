//
//  DicyController.swift
//  Dicy
//
//  Created by Pedro Simoes on 28/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import SwiftUI
import Combine

class DicyController: ObservableObject {
    
    let defaults = UserDefaults.standard
    
    @Published var results:[Int] = []
    @Published var addToggleIsPressed:Bool = false
    @Published var resultString:String = ""
    @Published var savedPresets:[Preset] = []
    
    let publisher = PassthroughSubject<String, Never>()
    var diceValue: String {
        willSet { objectWillChange.send() }
        didSet { publisher.send(diceValue) }
    }
    
    init() {
        self.diceValue = ""
        if let presetsFromUserDefaults = readPresetsFromUserDefaults() {
            savedPresets = presetsFromUserDefaults
        } else {
            savedPresets = [
                Preset(id: "Attack roll", diceFormula: "1d20+4"),
                Preset(id: "Sneak Attack damage", diceFormula: "3d6")
            ]
        }
    }
}
