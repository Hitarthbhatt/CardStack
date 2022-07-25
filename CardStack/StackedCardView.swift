//
//  StackedCardView.swift
//  AI-HealthWatch Extension
//
//  Created by Hitarth on 16/03/22.
//  Copyright © 2022 Simform. All rights reserved.
//

import SwiftUI

struct StackedCardView: View {
    
    @StateObject var controller = StackController()
    @GestureState var translation: CGFloat = .zero
    var cardHeight: CGFloat = 200
    
    var body: some View {
        ZStack {
            ForEach(controller.cards) { card in
                Rectangle()
                    .foregroundColor(card.color)
                    .cornerRadius(4)
                    .frame(maxWidth: ScreenDimension.width/1.5 - 10)
                    .frame(height: cardHeight)
                    .padding(.top, -card.padding)
                    .zIndex(Double(controller.cards.count - controller.getCardIndex(of: card)))
                    .offset(y: card.offset)
                    .opacity(card.opacity)
            } // ForEack
        } // ZStack
        .gesture(dragGesture())
        .disabled(controller.isAnimating)
        .onAnimationCompletion(for: controller.animationEnded) {
            controller.completeAnimation()
        }
    }
    
    func dragGesture() -> _EndedGesture<GestureStateGesture<DragGesture, CGFloat>> {
        DragGesture()
            .updating($translation, body: { value, state, _ in
                state = value.translation.height
                print(state)
                DispatchQueue.main.async {
                    controller.isReversed = value.translation.height < 0 ? true : false
                    if value.translation.height > 0 && !controller.isAnimating {
                        controller.changeCardByIndex(state: value.translation.height)
                    }
                }
            })
            .onEnded({ value in
                let position = value.translation.height
                DispatchQueue.main.async {
                    if position > cardHeight/2 || position < -cardHeight/2 {
                        controller.performAnimationByIndex()
                    } else {
                        controller.resetValue()
                    }
                }
            })
    }
    
}
