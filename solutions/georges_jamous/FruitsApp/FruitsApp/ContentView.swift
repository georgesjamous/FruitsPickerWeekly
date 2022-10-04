//
//  ContentView.swift
//  FruitsApp
//
//  Created by Jamous, Georges (formerly Georges) on 20/9/22.
//

import SwiftUI

let AllFruits = ["🍎 Apple", "🍌 Banana", "🍊 Orange", "🥝 Kiwi", "🥑 Avocado", "🫐 Berries", " 🥥Coco"]

struct ContentView: View {
    enum Route: String, Identifiable {
        var id: String { rawValue }
        case oneFruit
        case multipleFruits
    }

    @State var route: Route?
    @State var fruits: [String] = []
    @State var fruit: String?

    var body: some View {
        List {
            Section(header: Text("My Fruit")) {
                Button("Pick one fruit", action: {
                    route = .oneFruit
                })
                if let fruit = fruit {
                    Text(fruit)
                }
            }
            Section(header: Text("My Fruits")) {
                Button("Pick many fruits", action: {
                    route = .multipleFruits
                })
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit)
                }
            }
        }
        .sheet(item: $route, content: { route in
            switch route {
            case .oneFruit:
                NavigationView {
                    FruitPickerView(fruit: $fruit)
                }
            case .multipleFruits:
                NavigationView {
                    FruitPickerView(fruits: $fruits)
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
