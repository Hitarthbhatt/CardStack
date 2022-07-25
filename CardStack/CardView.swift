//
//  CardView.swift
//  CardStack
//
//  Created by Hitarth on 25/07/22.
//

import SwiftUI

struct CardView<Content: View, Item: Identifiable>: View {
    var item: Item
    @ViewBuilder var content: (Item) -> Content
    
    var body: some View {
        content(item)
    }
}
