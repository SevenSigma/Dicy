//
//  DiceText.swift
//  Dicy
//
//  Created by Pedro Simoes on 31/01/20.
//  Copyright © 2020 Pedro Simoes. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class DiceText<String>: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    let publisher = PassthroughSubject<String, Never>()
    var value: String {
        willSet { objectWillChange.send() }
        didSet { publisher.send(value) }
    }
    
    init(_ initValue: String) {self.value = initValue}
    
}
