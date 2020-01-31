//
//  ContentView.swift
//  Dicy
//
//  Created by Pedro Simoes on 09/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var dicy = DicyController()
    @State var textField = ""
    @State var selectedPreset = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // MARK: Quick Roll View
            Text("Quick Roll")
                .font(.subheadline)
                .padding([.top, .leading])
            Toggle(isOn: $dicy.addToggleIsPressed) {
                Text("Add results")
            }
            .padding(.leading)
            QuickRollView(dicy: dicy)
            
            // MARK: Presets View
            VStack(alignment: .leading) {
                Text("Presets")
                    .font(.subheadline)
                VStack {
                    HStack {
                        Picker(selection: $dicy.selectedPreset, label:EmptyView()) {
                            ForEach(self.dicy.savedPresets) { preset in
                                Text(preset.id)
                            }
                        }
                        .onReceive(dicy.publisher, perform: {
                            let newChosenPreset = $0
                            let chosenPresetDiceFormula = self.dicy.savedPresets.filter({ return $0.id == self.dicy.selectedPreset })
                            self.textField = chosenPresetDiceFormula[0].diceFormula
                        })
                        Button(action: {
                            // Adds a new preset with the current dice formula and the identifier "New Preset"
                            // TODO: Pop up an alert to fill both the id and the dice formula
                            let newPreset = Preset(id: "New preset", diceFormula: self.textField)
                            self.dicy.savedPresets.append(newPreset)
                            savePresetsToUserDefaults(presets: self.dicy.savedPresets)
                        }) {
                            Text("+")
                        }
                        Button(action: {
                            // Removes the currently selected preset
                            self.dicy.savedPresets = self.dicy.savedPresets.filter({ return $0.id != self.dicy.selectedPreset })
                            savePresetsToUserDefaults(presets: self.dicy.savedPresets)
                        }) {
                            Text("-")
                        }
                    }
                    .padding(.trailing)
                    HStack {
                        TextField("Try typing 3d6", text: $textField, onCommit: {
                            self.dicy.resultString = parseDice(fromString: self.textField)
                        })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                            self.dicy.resultString = parseDice(fromString: self.textField)
                        }) {
                            Text("Roll")
                        }
                        .padding([.trailing])
                    }
                }
            }
            .padding(.leading)
            
            // MARK: Results View
            VStack(alignment: .leading) {
                Text("Results")
                    .font(.subheadline)
                HStack {
                    Spacer()
                    if dicy.resultString == "" {
                        Text("Your dice rolls will appear here")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    } else {
                        Text(dicy.resultString)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action:{
                        self.dicy.resultString = ""
                        self.dicy.results = []
                    }) {
                        Text("C")
                    }
                }
            }
            .padding(.all)
        }
        .frame(width: 390.0)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
