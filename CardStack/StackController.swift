//
//  StackController.swift
//  CardStack
//
//  Created by Hitarth on 25/07/22.
//

import SwiftUI

class StackController: ObservableObject {
    
    @Published var cards: [Cards] = [
        .init(id: 0, offset: 0, color: .red, opacity: 1, padding: 0),
        .init(id: 1, offset: 0, color: .green, opacity: 1, padding: 10),
        .init(id: 2, offset: 0, color: .orange, opacity: 1, padding: 10),
    ]
    
    @Published var currentCard: Int = 0
    @Published var animationEnded: Double = 0

    @Published var isReversed: Bool = false
    @Published var isAnimating: Bool = false
    
    func changeCardByIndex(state: Double) {
        let lastIndex = self.cards.count - 1
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else {return}
            withAnimation {
                self.cards[self.currentCard].offset = state
                self.cards[lastIndex].opacity = 1
            }
        }
    }
    
    func performAnimationByIndex() {
        self.isAnimating = true
        withAnimation(.easeInOut(duration: 0.4)) {
            if !isReversed {
                cards[currentCard].offset = ScreenDimension.height
                cards[currentCard].padding = 10
                cards[currentCard].opacity = 0
                cards[currentCard + 1].padding = 0
            }
            animationEnded = Double.random(in: 0...4)
        }
    }
    
    func completeAnimation() {
        isReversed ? cards.rotateSingleLeft() : cards.rotateSingleRight()
        cards[currentCard].offset = isReversed ? ScreenDimension.height : 0
        withAnimation(.easeInOut(duration: 0.4)) {
            cards[currentCard].padding = 0
            cards[currentCard].offset = 0
            cards[currentCard].opacity = 1
            
            for index in cards.indices where index != currentCard {
                cards[index].padding = 10
                cards[index].offset = 0
            }
            isAnimating = false
        }
    }
    
    func resetValue() {
        withAnimation {
            self.cards[self.currentCard].offset = 0
        }
    }
    
    func getCardIndex(of currentCard: Cards) -> Int {
        let index = cards.firstIndex { card in
            return card.id == currentCard.id
        } ?? 0
        return index
    }
    
}

struct Cards: Identifiable, Hashable {
    var id: Int
    var offset: Double
    var color: Color
    var opacity: Double
    var padding: Double
}
