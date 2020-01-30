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
    @State var showQuickRoll = true
    @State var showPresets = true
    @State var textField = ""
    @State var selectedPreset = ""
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // MARK: Quick Roll View
            Text("Quick Roll")
                .font(.subheadline)
                .padding([.top, .leading])
            if showQuickRoll == true {
                Toggle(isOn: $dicy.addToggleIsPressed) {
                    Text("Add results")
                }
                .padding(.leading)
                QuickRollView(dicy: dicy)
                    .transition(.scale(scale: 0.001, anchor: .top))
            }
            
            // MARK: Presets View
            VStack(alignment: .leading) {
                Text("Presets")
                    .font(.subheadline)
                if showPresets == true {
                    VStack {
                        HStack {
                            
                            // TODO: Make the current selected preset fill the Dice Formula text field
                            Picker(selection: $selectedPreset, label:EmptyView()) {
                                ForEach(self.dicy.savedPresets) { preset in
                                    Text(preset.id)
                                }

                            }
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
                                self.dicy.savedPresets = self.dicy.savedPresets.filter({ return $0.id != self.selectedPreset })
                                savePresetsToUserDefaults(presets: self.dicy.savedPresets)
                            }) {
                                Text("-")
                            }
                        }
                        .padding(.trailing)
                        HStack {
                            TextField("Try typing 3d6", text: $textField, onCommit: {
                                withAnimation(.spring()) {
                                    self.dicy.resultString = parseDice(fromString: self.textField)
                                }
                            })
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                            Button(action: {
                                withAnimation(.spring()) {
                                    self.dicy.resultString = parseDice(fromString: self.textField)
                                }
                            }) {
                                Text("Roll")
                            }
                            .padding([.trailing])
                        }
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
                    Text(dicy.resultString)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action:{
                        self.dicy.resultString = ""
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
