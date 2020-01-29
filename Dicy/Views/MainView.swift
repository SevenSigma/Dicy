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
    
    var body: some View {
        VStack(alignment: .leading) {
            Button (action: {
                withAnimation {
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
                QuickRollView(dicy: dicy)
                    .transition(.opacity)
            }
            VStack(alignment: .leading) {
                Button (action: { self.showPresets.toggle() }){
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
                            TextField("Try typing 3d6", text: $dicy.diceFormula)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button(action: {
                                self.dicy.resultString = parseDice(fromString: self.dicy.diceFormula)!
                            }) {
                                Text("Roll")
                            }
                            .padding([.trailing])
                        }
                    }
                }
            }
            .padding(.leading)
            
            VStack(alignment: .leading) {
                Button (action: {}){
                    Text("Results")
                        .font(.subheadline)
                }.buttonStyle(PlainButtonStyle())
                HStack {
                    Spacer()
                    Text(dicy.resultString)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(dicy.isResultsEmpty ? Color.gray : Color("TextColor"))
                        .opacity(dicy.isResultsEmpty ? 0 : 100)
                        .fixedSize(horizontal: false, vertical: true)
                        .animation(Animation.spring().speed(5))
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action:{
                        self.dicy.results = []
                        self.dicy.isResultsEmpty = true
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
