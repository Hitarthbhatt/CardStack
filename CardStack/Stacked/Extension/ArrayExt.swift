//
//  ArrayExt.swift
//  CardStack
//
//  Created by Hitarth on 25/07/22.
//

import SwiftUI

extension Array {
    mutating func rotateSingleRight() {
        let first = self[0]
        for i in (0..<self.count - 1) {
            self[i] = self[i + 1]
        }
        self[self.count - 1] = first
    }
    
    mutating func rotateSingleLeft() {
        let last = self[self.count - 1]
        for i in (1..<self.count).reversed() {
            self[i] = self[i - 1]
        }
        self[0] = last
    }
}
