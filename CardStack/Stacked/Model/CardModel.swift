//
//  CardModel.swift
//  CardStack
//
//  Created by Hitarth on 26/07/22.
//

import SwiftUI

struct Cards<Item>: Identifiable {
    var id: Int
    var item: Item
    var offset: Double
    var opacity: Double
    var padding: Double
}
