//
//  DicyController.swift
//  Dicy
//
//  Created by Pedro Simoes on 28/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import SwiftUI
import Combine

// Why does this have both @Published variables and a PassThroughSubject? Because the SwiftUI Picker does not have a onSet method, so we had to get creative and implement an onReceive alternative.
class DicyController: ObservableObject {
    
    let defaults = UserDefaults.standard
    
    @Published var results:[Int] = []
    @Published var addToggleIsPressed:Bool = false
    @Published var resultString:String = ""
    @Published var savedPresets:[Preset] = []
    
    // This is adding onReceive functionality to the SwiftUI picker in the main view.
    let publisher = PassthroughSubject<String, Never>()
    var selectedPreset: String {
        willSet { objectWillChange.send() }
        didSet { publisher.send(selectedPreset) }
    }
    
    init() {
        self.selectedPreset = ""
        // Checks if there are saved presets in UserDefaults, else loads the starter presets.
        if let presetsFromUserDefaults = readPresetsFromUserDefaults() {
            savedPresets = presetsFromUserDefaults
        } else {
            savedPresets = [
                Preset(id: "Attack roll", diceFormula: "1d20+4"),
                Preset(id: "Sword damage", diceFormula: "1d8+2"),
                Preset(id: "Sneak Attack damage", diceFormula: "3d6"),
                Preset(id: "Critical sneak attack", diceFormula: "2d8+2+6d6")
            ]
        }
    }
}
