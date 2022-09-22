//
//  ContentView.swift
//  FruitsApp
//
//  Created by Jamous, Georges (formerly Georges) on 20/9/22.
//

import SwiftUI

struct ContentView: View {
    @State var isPickingFruits: Bool = false

    var body: some View {
        Button("Pick Fruit(s)", action: {
            isPickingFruits = true
        })
        .sheet(isPresented: $isPickingFruits) {
            NavigationView {
                FruitsPickerView()
                    .navigationTitle("Fruit Store")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
