//
//  StackedCardView.swift
//  AI-HealthWatch Extension
//
//  Created by Hitarth on 16/03/22.
//  Copyright © 2022 Simform. All rights reserved.
//

import SwiftUI

struct StackedCardView<Content: View, Item>: View {
    
    private let items: [Item]
    private let cardControl: CardController
    private let content: (Item) -> Content
    private var onItemChange: (Int) -> Void
    private var cardHeight: CGFloat
    private var cardWidth: CGFloat
    
    
    @StateObject var stackController = StackController<Item>()
    @GestureState var translation: CGFloat = .zero
    
    init(items: [Item], cardControl: CardController, @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.cardControl = cardControl
        self.content = content
        
        self.onItemChange = { _ in }
        self.cardWidth = ScreenDimension.width/1.5
        self.cardHeight = 200
        
    }
    
    var body: some View {
        ZStack {
            ForEach(stackController.cards) { card in
                content(card.item)
                    .frame(maxWidth: cardWidth - 10)
                    .frame(height: cardHeight)
                    .padding(.top, -card.padding)
                    .zIndex(Double(stackController.cards.count - stackController.getCardIndex(of: card)))
                    .offset(y: card.offset)
                    .opacity(card.opacity)
            } // ForEack
        } // ZStack
        .gesture(dragGesture())
        .disabled(stackController.isAnimating)
        .onAnimationCompletion(for: stackController.animationEnded) {
            stackController.completeAnimation(items: items)
        }
        .onAppear {
            if stackController.cards.isEmpty {
                stackController.setCards(index: 0, items: items)
            }
        }
        .onChange(of: stackController.itemIndex) { newValue in
            onItemChange(newValue)
        }
        .onReceive(cardControl.cardUpdate) { type in
            if !stackController.isAnimating {
                stackController.updateCards(type: type, items: items)
            }
        }
    }
    
    func dragGesture() -> _EndedGesture<GestureStateGesture<DragGesture, CGFloat>> {
        DragGesture()
            .updating($translation, body: { value, state, _ in
                state = value.translation.height
                DispatchQueue.main.async {
                    stackController.isReversed = value.translation.height < 0 ? true : false
                    if value.translation.height > 0 && stackController.itemIndex < items.count - 1 {
                        stackController.changeCardByIndex(state: value.translation.height)
                    }
                }
            })
            .onEnded({ value in
                let position = value.translation.height
                DispatchQueue.main.async {
                    if position > cardHeight/2 || position < -cardHeight/2 {
                        stackController.performAnimationByIndex(items: items)
                    } else {
                        stackController.resetValue()
                    }
                }
            })
    }
    
}

extension StackedCardView {
    public func cardHeight(_ height: Double) -> StackedCardView {
        var result = self
        result.cardHeight = height
        return result
    }
    
    public func cardWidht(_ width: Double) -> StackedCardView {
        var result = self
        result.cardWidth = width
        return result
    }
    
    public func onCardChange(_ onChange: @escaping (Int) -> Void) -> StackedCardView {
        var result = self
        result.onItemChange = onChange
        return result
    }
}
