//
//  FruitPickerView.swift
//  FruitsApp
//
//  Created by Jamous, Georges (formerly Georges) on 4/10/22.
//

import SwiftUI

struct FruitPickerView: View {
    /// Returns the Picker with a single selection
    /// - Parameter fruit: the single fruit when selected
    init(fruit: Binding<String?> = .constant(nil)) {
        _externalSelectedFruits = .init(get: {
            if let fruit = fruit.wrappedValue {
                return [fruit]
            }
            return []
        }, set: { newFruits in
            fruit.wrappedValue = newFruits.first
        })
        isSingleSelection = true
    }

    /// Returns the Picker with a multiple selection
    /// - Parameter fruits: the fruits selected
    init(fruits: Binding<[String]> = .constant([])) {
        _externalSelectedFruits = fruits
        isSingleSelection = false
    }

    @Binding private var externalSelectedFruits: [String]
    @State private var selectedFruits: Set<String> = Set()
    private var isSingleSelection: Bool

    var body: some View {
        List(AllFruits, id: \.self) { fruit in
            Button {
                tapped(fruit: fruit)
            } label: {
                DefaultFruitRow(
                    fruit: fruit,
                    isSelected: isSelected(fruit: fruit)
                )
            }
        }
        // after we update our own state
        // expose it to the parent
        .onChange(of: selectedFruits) { newValue in
            externalSelectedFruits = Array(newValue)
        }
        // on appear we want to load the parent's state
        .onAppear {
            selectedFruits = Set(externalSelectedFruits)
        }
    }

    func tapped(fruit: String) {
        if isSingleSelection {
            selectedFruits.removeAll()
        }
        if selectedFruits.contains(fruit) {
            selectedFruits.remove(fruit)
        } else {
            selectedFruits.insert(fruit)
        }
    }

    func isSelected(fruit: String) -> Bool {
        selectedFruits.contains(fruit)
    }
}

struct DefaultFruitRow: View {
    let fruit: String
    let isSelected: Bool

    var body: some View {
        HStack {
            Text(fruit)
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(checkmarkForegroundColor)
        }
    }

    var checkmarkForegroundColor: Color {
        !isSelected ? Color.gray.opacity(0.5) : Color.green
    }
}

struct FruitPickerView_Previews: PreviewProvider {
    
    struct PreviewContainer: View {
        
        @State var fruits: [String] = []
        @State var fruit: String?

        var body: some View {
            VStack {
                NavigationView {
                    FruitPickerView(fruits: $fruits)
                        .navigationTitle(fruits.joined(separator: "-"))
                }
                NavigationView {
                    FruitPickerView(fruit: $fruit)
                        .navigationTitle(fruit ?? "")
                }
            }
        }

    }
    
    static var previews: some View {
        PreviewContainer()
    }
    
}
