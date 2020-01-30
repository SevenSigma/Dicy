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
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Quick Roll View
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
            
            // Presets View
            VStack(alignment: .leading) {
                Text("Presets")
                    .font(.subheadline)
                if showPresets == true {
                    VStack {
                        HStack {
                            
                            // TODO: Implement the picker
                            Picker(selection: $selectedPreset, label:EmptyView()) {
                                ForEach(self.dicy.savedPresets) { preset in
                                    Text(preset.id)
                                }

                            }
                            Button(action: {
                                self.dicy.savedPresets.append(Preset(id: "New preset", diceFormula: self.textField) )
                            }) {
                                Text("+")
                            }
                            Button(action: {
                                
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
            
            // Results View
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
