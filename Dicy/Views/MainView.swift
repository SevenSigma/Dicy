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
    @ObservedObject var parser = DiceParser()
    @State var showQuickRoll = true
    @State var showPresets = true
    @State var textField = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
//            Quick Roll View
            Button (action: {
                withAnimation(.spring()) {
                    self.showQuickRoll.toggle()
                }
            }){
                Text("Quick Roll")
                    .font(.subheadline)
                    .padding([.top, .leading])
            }.buttonStyle(PlainButtonStyle())
            if showQuickRoll == true {
                Toggle(isOn: $dicy.addToggleIsPressed) {
                    Text("Add results")
                }
                .padding(.leading)
                QuickRollView(dicy: dicy, parser: parser)
                    .transition(.scale(scale: 0.001, anchor: .top))
            }
            
//            Presets View
            VStack(alignment: .leading) {
                Button (action: {
                    withAnimation(.spring()) {
                        self.showPresets.toggle()
                    }
                }){
                    Text("Presets")
                        .font(.subheadline)
                }.buttonStyle(PlainButtonStyle())
                if showPresets == true {
                    VStack {
                        HStack {
                            Picker(selection:.constant(1), label:EmptyView()) {
                                Text("1").tag(1)
                                Text("2").tag(2)
                                Text("3").tag(3)
                            }
                            Button(action: {}) {
                                Text("+")
                            }
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                Text("-")
                            }
                        }
                        .padding(.trailing)
                        HStack {
                            TextField("Try typing 3d6", text: $textField, onCommit: {
                                withAnimation(.spring()) {
                                self.parser.parseDice(fromString: self.textField)
                                }
                            })
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button(action: {
                                withAnimation(.spring()) {
                                    self.parser.parseDice(fromString: self.textField)
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
            
//            Results View
            VStack(alignment: .leading) {
                Text("Results")
                    .font(.subheadline)
                
                HStack {
                    Spacer()
                    Text(parser.results)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action:{
                        self.parser.results = ""
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
