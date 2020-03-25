//
//  Card.swift
//  Concentration
//
//  Created by Sneh Patel on 3/24/20.
//  Copyright © 2020 Sneh Patel. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var indentifierFactory = 0
    
    static func getUniqueIndentifier() -> Int{
        indentifierFactory += 1
        return indentifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIndentifier()
    }
}
