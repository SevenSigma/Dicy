//
//  AddPresetModal.swift
//  Dicy
//
//  Created by Pedro Simoes on 31/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import SwiftUI

struct PresetView: View {
    
    let dicy: DicyController
    @State var presetName = "New Preset"
    @State var diceFormula = "3d6"
    @Binding var showPresetView: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            TextField("Preset name", text: $presetName, onCommit: {
                print("")
            })
            TextField("Dice formula", text: $diceFormula, onCommit: {
                print("")
            })
            HStack {
                Button(action: {
                    self.showPresetView = false
                }) {
                    Text("Cancel")
                }
                Button(action: {
                    let newPreset = Preset(id: self.presetName, diceFormula: self.diceFormula)
                    // If it is a new preset, adds it to the list
                    if self.dicy.savedPresets.filter({ return $0.id == newPreset.id }).isEmpty {
                        self.dicy.savedPresets.append(newPreset)
                        savePresetsToUserDefaults(presets: self.dicy.savedPresets)
                        self.showPresetView = false
                    } else {
                        // If there is a preset with that name already, replace its diceFormula
                        let oldPreset = self.dicy.savedPresets.filter({ return $0.id == newPreset.id }).first
                        if let index = self.dicy.savedPresets.firstIndex(of: oldPreset!) {
                            self.dicy.savedPresets.remove(at: index)
                            self.dicy.savedPresets.append(newPreset)
                            savePresetsToUserDefaults(presets: self.dicy.savedPresets)
                            self.showPresetView = false
                        }

                    }
                }) {
                    Text("Add Preset")
                }
            }
        }
        .padding(.all)
    }
}

//struct PresetView_Previews: PreviewProvider {
//    static var previews: some View {
//        PresetView(dicy: DicyController())
//    }
//}
