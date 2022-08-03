//
//  CardUpdate.swift
//  CardStack
//
//  Created by Hitarth on 01/08/22.
//

import SwiftUI

enum CardUpdate {
    case next
    case previous
    case first
    case last
    case atIndex(index: Int)
}
