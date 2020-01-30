//
//  Preset.swift
//  Dicy
//
//  Created by Pedro Simoes on 30/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import Foundation

struct Preset: Identifiable, Codable {
    let id: String
    let diceFormula: String
}

// TODO: Implement the read and save preset functions
func savePresetsToUserDefaults(presets: [Preset]) {
    // Convert an array of presets into JSON data, then saves the data to UserDefaults.plist
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(presets) {
        UserDefaults.standard.set(encoded, forKey: "presets")
    }

}

func readPresetsFromUserDefaults() -> [Preset]? {
    // Reads the presets data from the UserDefaults.plist into an array of Preset objects
    if let presetsFromDefaults = UserDefaults.standard.object(forKey: "presets") as? Data {
        let decoder = JSONDecoder()
        if let loadedPresets = try? decoder.decode([Preset].self, from: presetsFromDefaults) {
            return loadedPresets
        } else { return nil }
    } else { return nil }
}
