//
//  SeparatedPickers.swift
//  FruitsApp
//
//  Created by Jamous, Georges (formerly Georges) on 4/10/22.
//

import SwiftUI

//enum FruitPicker {
//    static func single(fruits: Binding<[String]): SingleFruitsPickerView {
//        return SingleFruitsPickerView()
//    }
//    static func many(fruits: Binding<[String]): MultipleFruitPickerView {
//        return MultipleFruitPickerView()
//    }
//}

struct SingleFruitsPickerView: View {
    @Binding var selected: String?
    @State private var selectedFruit: String?

    var body: some View {
        List(AllFruits, id: \.self) { fruit in
            Button {
                self.selectedFruit = fruit
            } label: {
                FruitRow(
                    fruit: fruit,
                    isSelected: fruit == selectedFruit
                )
            }
        }
        .onChange(of: selectedFruit) { newValue in
            self.selected = newValue
        }
    }
}

struct MultipleFruitPickerView: View {
    @Binding var fruits: [String]

    @State private var selectedFruits: [String] = []

    var body: some View {
        List(AllFruits, id: \.self) { fruit in
            Button {
                tapped(fruit: fruit)
            } label: {
                FruitRow(
                    fruit: fruit,
                    isSelected: selectedFruits.contains(fruit)
                )
            }
        }
        .onChange(of: selectedFruits) { newValue in
            self.fruits = newValue
        }
        .onAppear {
            selectedFruits = fruits
        }
    }

    func tapped(fruit: String) {
        if selectedFruits.contains(fruit) {
            selectedFruits.removeAll(where: { $0 == fruit })
        } else {
            selectedFruits.append(fruit)
        }
    }
}
