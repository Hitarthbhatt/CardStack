//
//  StackController.swift
//  CardStack
//
//  Created by Hitarth on 25/07/22.
//

import SwiftUI

class StackController<Item>: ObservableObject {
    
    // MARK: - Variables.
    @Published var cards: [Cards<Item>] = []
    
    @Published var itemIndex: Int = 0
    @Published var currentCard: Int = 0
    @Published var animationEnded: Double = 0

    @Published var isReversed: Bool = false
    @Published var isAnimating: Bool = false
    
    // MARK: - Card configuration methods.
    func setCards(index: Int, items: [Item]) {
        cards.removeAll()
        
        if index < 0 {
            itemIndex = 0
        } else if index > items.count {
            itemIndex = items.count - 1
        } else {
            itemIndex = index
        }
        
        for i in itemIndex...(itemIndex + 2) {
            if i == itemIndex {
                cards.append(Cards(id: i, item: items[i], offset: 0, opacity: 1, padding: 0))
            } else {
                if items.indices.contains(i) {
                    cards.append(Cards(id: i, item: items[i], offset: 0, opacity: 1, padding: 10))
                } else {
                    cards.append(Cards(id: i, item: items[itemIndex], offset: 0, opacity: 1, padding: 10))
                }
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
    
    func updateCards(type: CardUpdate, items: [Item]) {
        switch type {
            case .previous:
                isReversed = true
                if itemIndex > 0 {
                    performAnimationByIndex(items: items)
                }
            case .next:
                isReversed = false
                if itemIndex < items.count - 1 {
                    performAnimationByIndex(items: items)
                }
            case .first:
                return
            case .last:
                return
            case .atIndex(let index):
                withAnimation(.easeInOut(duration: 0.5)) {
                    setCards(index: index, items: items)
                }
        }
    }
    
    // MARK: - Cards animation methods.
    func changeCardByIndex(state: Double) {
        withAnimation {
            self.cards[self.currentCard].offset = state
        }
    }
    
    func performAnimationByIndex(items: [Item], duration: Double = 0.4) {
        isAnimating = true
        let lastIndex = cards.count - 1
        let lastItemIndex = items.count - 1
        
        withAnimation(.interactiveSpring(response: isReversed ? duration/10 : duration, dampingFraction: 1, blendDuration: 1)) {
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
    
    func completeAnimation(items: [Item], duration: Double = 0.4) {
        isReversed ? cards.rotateSingleLeft() : cards.rotateSingleRight()
        cards[currentCard].offset = isReversed ? ScreenDimension.height : 0
        changeCardItem(items: items)
        withAnimation(.interactiveSpring(response: isReversed ? duration : duration/10 , dampingFraction: 0.9, blendDuration: 0.5)) {
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
    
    // MARK: - Util methods.
    func getCardIndex(of currentCard: Cards<Item>) -> Int {
        let index = cards.firstIndex { card in
            return card.id == currentCard.id
        } ?? 0
        return index
    }
    
}
