//
//  ContentView.swift
//  AI-HealthWatch Extension
//
//  Created by Pradeep Chakoriya on 14/03/22.
//  Copyright © 2022 Simform. All rights reserved.
//

import SwiftUI

struct DataItem: Identifiable {
    var id: UUID = UUID()
    var color: Color
    var name: String
    var image: String
}

struct ContentView: View {
    
    let items: [DataItem] = [
        .init(color: .red, name: "airplane", image: "airplane"),
        .init(color: .orange, name: "car", image: "car"),
        .init(color: .yellow, name: "tram", image: "tram"),
        .init(color: .purple, name: "bus", image: "bus"),
        .init(color: .indigo, name: "ferry", image: "ferry"),
        .init(color: .cyan, name: "bicycle", image: "bicycle"),
        .init(color: .green, name: "bolt", image: "bolt"),
        .init(color: .black, name: "fuelpump", image: "fuelpump"),
        .init(color: .red, name: "airplane", image: "airplane"),
        .init(color: .orange, name: "car", image: "car"),
        .init(color: .yellow, name: "tram", image: "tram"),
        .init(color: .purple, name: "bus", image: "bus"),
        .init(color: .indigo, name: "ferry", image: "ferry"),
        .init(color: .cyan, name: "bicycle", image: "bicycle"),
        .init(color: .green, name: "bolt", image: "bolt"),
        .init(color: .black, name: "fuelpump", image: "fuelpump"),
        .init(color: .red, name: "airplane", image: "airplane"),
        .init(color: .orange, name: "car", image: "car"),
        .init(color: .yellow, name: "tram", image: "tram"),
        .init(color: .purple, name: "bus", image: "bus"),
        .init(color: .indigo, name: "ferry", image: "ferry"),
        .init(color: .cyan, name: "bicycle", image: "bicycle"),
        .init(color: .green, name: "bolt", image: "bolt"),
        .init(color: .black, name: "fuelpump", image: "fuelpump"),
        .init(color: .red, name: "airplane", image: "airplane"),
        .init(color: .orange, name: "car", image: "car"),
        .init(color: .yellow, name: "tram", image: "tram"),
        .init(color: .purple, name: "bus", image: "bus"),
        .init(color: .indigo, name: "ferry", image: "ferry"),
        .init(color: .cyan, name: "bicycle", image: "bicycle"),
        .init(color: .green, name: "bolt", image: "bolt"),
        .init(color: .black, name: "fuelpump", image: "fuelpump"),
        .init(color: .red, name: "airplane", image: "airplane"),
        .init(color: .orange, name: "car", image: "car"),
        .init(color: .yellow, name: "tram", image: "tram"),
        .init(color: .purple, name: "bus", image: "bus"),
        .init(color: .indigo, name: "ferry", image: "ferry"),
        .init(color: .cyan, name: "bicycle", image: "bicycle"),
        .init(color: .green, name: "bolt", image: "bolt"),
        .init(color: .black, name: "fuelpump", image: "fuelpump"),
        .init(color: .red, name: "airplane", image: "airplane"),
        .init(color: .orange, name: "car", image: "car"),
        .init(color: .yellow, name: "tram", image: "tram"),
        .init(color: .purple, name: "bus", image: "bus"),
        .init(color: .indigo, name: "ferry", image: "ferry"),
        .init(color: .cyan, name: "bicycle", image: "bicycle"),
        .init(color: .green, name: "bolt", image: "bolt"),
        .init(color: .black, name: "fuelpump", image: "fuelpump"),
        .init(color: .red, name: "airplane", image: "airplane"),
        .init(color: .orange, name: "car", image: "car"),
        .init(color: .yellow, name: "tram", image: "tram"),
        .init(color: .purple, name: "bus", image: "bus"),
        .init(color: .indigo, name: "ferry", image: "ferry"),
        .init(color: .cyan, name: "bicycle", image: "bicycle"),
        .init(color: .green, name: "bolt", image: "bolt"),
        .init(color: .black, name: "fuelpump", image: "fuelpump"),
        .init(color: .red, name: "airplane", image: "airplane"),
        .init(color: .orange, name: "car", image: "car"),
        .init(color: .yellow, name: "tram", image: "tram"),
        .init(color: .purple, name: "bus", image: "bus"),
        .init(color: .indigo, name: "ferry", image: "ferry"),
        .init(color: .cyan, name: "bicycle", image: "bicycle"),
        .init(color: .green, name: "bolt", image: "bolt"),
        .init(color: .black, name: "fuelpump", image: "fuelpump")
    ]
    
    var body: some View {
        StackedCardView(items: items) { item in
            VStack {
                Label(item.name, systemImage: item.name)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
                    .font(.title)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(item.color)
            .cornerRadius(10)
        }
        .onCardChange { index in
            print("Current card index is - \(index)")
        }
    }
}
