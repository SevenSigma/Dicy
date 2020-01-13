//
//  ContentView.swift
//  Dicy
//
//  Created by Pedro Simoes on 09/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var results:[Int] = []
    @State var addToggleIsPressed:Bool = false
    @State var isResultsEmpty:Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Button (action: {}){
                Text("Quick Roll")
                .font(.subheadline)
                .padding([.top, .leading])
            }.buttonStyle(PlainButtonStyle())
            VStack {
                HStack {
                    Button(action: {
                        if self.addToggleIsPressed == true {
                            self.results.append(quickRollDice(sides: 4))
                        } else {
                            self.results = [quickRollDice(sides: 4)]
                        }
                        self.isResultsEmpty = false
                    }) {
                        Image("d4")
                    }
                    Button(action: {
                        if self.addToggleIsPressed == true {
                            self.results.append(quickRollDice(sides: 6))
                        } else {
                            self.results = [quickRollDice(sides: 6)]
                        }
                        self.isResultsEmpty = false
                            
                        }) {
                            Image("d6")
                        }
                        Button(action: {
                        if self.addToggleIsPressed == true {
                            self.results.append(quickRollDice(sides: 8))
                        } else {
                            self.results = [quickRollDice(sides: 8)]
                        }
                        self.isResultsEmpty = false
                    }) {
                        Image("d8")
                    }
                }
                .buttonStyle(QuickRollButtonStyle())
                .padding(.leading)
                HStack {
                    Button(action: {
                        if self.addToggleIsPressed == true {
                            self.results.append(quickRollDice(sides: 10))
                        } else {
                            self.results = [quickRollDice(sides: 10)]
                        }
                        self.isResultsEmpty = false
                    }) {
                    Image("d10")
                    }
                    Button(action: {
                        if self.addToggleIsPressed == true {
                            self.results.append(quickRollDice(sides: 12))
                        } else {
                            self.results = [quickRollDice(sides: 12)]
                        }
                        self.isResultsEmpty = false
                    }) {
                        Image("d12")
                    }
                    Button(action: {
                        if self.addToggleIsPressed == true {
                            self.results.append(quickRollDice(sides: 20))
                        } else {
                            self.results = [quickRollDice(sides: 20)]
                        }
                        self.isResultsEmpty = false
                    }) {
                        Image("d20")
                    }
                }
                .buttonStyle(QuickRollButtonStyle())
                .padding(.leading)
                    
            }
            VStack(alignment: .leading) {
                Button (action: {}){
                    Text("Presets")
                    .font(.subheadline)
                }.buttonStyle(PlainButtonStyle())

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
                            TextField("Try typing 3d6", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                Text("Roll  ")
                                }
                            .padding([.trailing])
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
                        Text("\(results.description) = \(results.reduce(0,+))")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foregroundColor(isResultsEmpty ? Color.gray : Color("TextColor"))
                            .opacity(isResultsEmpty ? 0 : 100)
                        Spacer()
                    }
                    HStack {
                        Toggle(isOn: $addToggleIsPressed) {
                            Text("Add results")
                        }
                        Spacer()
                        Button(action:{
                            self.results = []
                            self.isResultsEmpty = true
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

struct QuickRollButtonStyle: ButtonStyle {
    public func makeBody(configuration: QuickRollButtonStyle.Configuration) -> some View {
        
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(Animation.spring().speed(5))
    }
}

func quickRollDice (sides:Int) -> Int {
    let dieRoll = Int.random(in: 1...sides)
    return dieRoll
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
