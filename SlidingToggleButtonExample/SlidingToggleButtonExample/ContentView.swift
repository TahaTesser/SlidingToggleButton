//
//  ContentView.swift
//  SlidingToggleButtonExample
//
//  Created by Taha Tesser on 25.12.2024.
//

import SlidingToggleButton
import SwiftUI

struct ContentView: View {
    @State private var isToggled = false

    var body: some View {
        HStack {
            SlidingToggleButton(
                isToggled: $isToggled,
                size: 20,
                startIconName: "sun.max.fill",
                endIconName: "moon.fill"
            )
            SlidingToggleButton(
                isToggled: $isToggled,
                size: 20,
                vertical: true,
                startIconName: "sun.max.fill",
                endIconName: "moon.fill"
            )
        }
    }
}

#Preview {
    ContentView()
}
