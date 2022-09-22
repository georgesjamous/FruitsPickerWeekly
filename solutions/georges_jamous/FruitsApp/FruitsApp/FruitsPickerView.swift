//
//  FruitsPickerView.swift
//  FruitsApp
//
//  Created by Jamous, Georges (formerly Georges) on 20/9/22.
//

import SwiftUI

let AllFruits = ["🍎Apple", "🍌Banana", "🍊Orange", "🥝Kiwi", "🥑Avocado", "🫐Berries", "🥥Coco"]

struct FruitsPickerView: View {
    var body: some View {
        List {
            Text("Hello, World!")
        }
    }
}

struct FruitsPickerView_Previews: PreviewProvider {
    static var previews: some View {
        FruitsPickerView()
    }
}
