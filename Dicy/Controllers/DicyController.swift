//
//  DicyController.swift
//  Dicy
//
//  Created by Pedro Simoes on 28/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import SwiftUI

class DicyController: ObservableObject {
    
    @Published var results:[Int] = []
    @Published var addToggleIsPressed:Bool = false
    @Published var isResultsEmpty:Bool = false
    @Published var diceFormula:String = ""
    @Published var resultString:String = ""
    
}
