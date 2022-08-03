//
//  CardController.swift
//  CardStack
//
//  Created by Hitarth on 28/07/22.
//

import SwiftUI
import Combine

class CardController: ObservableObject {
    
    var cardUpdate = PassthroughSubject<CardUpdate, Never>()
    
    func update(_ update: CardUpdate) {
        cardUpdate.send(update)
    }
    
}
