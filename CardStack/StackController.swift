//
//  StackController.swift
//  CardStack
//
//  Created by Hitarth on 25/07/22.
//

import SwiftUI

class StackController<Item>: ObservableObject {
    
    @Published var cards: [Cards<Item>] = []
    
    @Published var itemIndex: Int = 0
    @Published var currentCard: Int = 0
    @Published var animationEnded: Double = 0

    @Published var isReversed: Bool = false
    @Published var isAnimating: Bool = false
    
    func setCards(items: [Item]) {
        for i in 0...2 {
            if i == 0 {
                cards.append(Cards(id: i, item: items[i], offset: 0, opacity: 1, padding: 0))
            } else {
                cards.append(Cards(id: i, item: items[i], offset: 0, opacity: 1, padding: 10))
            }
        }
    }
    
    func changeCardItem(items: [Item]) {
        if !isReversed && itemIndex + 2 < items.count {
            cards[cards.count - 1].item = items[itemIndex + 2]
        } else if isReversed && itemIndex >= 0 {
            cards[0].item = items[itemIndex]
        }
    }
    
    func changeCardByIndex(state: Double) {
        withAnimation {
            self.cards[self.currentCard].offset = state
        }
    }
    
    func performAnimationByIndex(items: [Item]) {
        isAnimating = true
        let lastIndex = cards.count - 1
        let lastItemIndex = items.count - 1
        
        withAnimation(.easeInOut(duration: 0.4)) {
            if !isReversed && itemIndex < lastItemIndex  {
                cards[currentCard].offset = ScreenDimension.height
                cards[currentCard].opacity = 0
                cards[currentCard + 1].padding = 0
                cards[lastIndex].opacity = 1
                
                itemIndex += 1
                animationEnded = Double.random(in: 0...4)
            } else if isReversed && itemIndex > 0 {
                
                itemIndex -= 1
                animationEnded = Double.random(in: 0...4)
            } else {
                isAnimating = false
            }
        }
    }
    
    func completeAnimation(items: [Item]) {
        isReversed ? cards.rotateSingleLeft() : cards.rotateSingleRight()
        cards[currentCard].offset = isReversed ? ScreenDimension.height : 0
        changeCardItem(items: items)
        withAnimation(.easeInOut(duration: 0.4)) {
            cards[currentCard].padding = 0
            cards[currentCard].offset = 0
            cards[currentCard].opacity = 1
            
            for index in cards.indices where index != currentCard {
                cards[index].padding = 10
                cards[index].offset = 0
            }
        }
        isAnimating = false
    }
    
    func resetValue() {
        withAnimation {
            cards[currentCard].offset = 0
        }
    }
    
    func getCardIndex(of currentCard: Cards<Item>) -> Int {
        let index = cards.firstIndex { card in
            return card.id == currentCard.id
        } ?? 0
        return index
    }
    
}
