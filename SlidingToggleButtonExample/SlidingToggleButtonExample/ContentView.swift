//
//  ContentView.swift
//  SlidingToggleButtonExample
//
//  Created by Taha Tesser on 25.12.2024.
//

import SwiftUI
import SlidingToggleButton

struct ContentView: View {
    
    @State private var isToggled = false
    
    var body: some View {
        NavigationStack {
            List {
                Text("Sample Content")
                Text("More Content")
            }
            .navigationTitle("SlidingToggleButton")
            .toolbar {
                ToolbarItem {
                    SlidingToggleButton(
                        isToggled: $isToggled,
                        size: 20
                    )
                }
            }
            .preferredColorScheme(isToggled ? .light : .dark)
        }
    }
}
#Preview {
    ContentView()
}
