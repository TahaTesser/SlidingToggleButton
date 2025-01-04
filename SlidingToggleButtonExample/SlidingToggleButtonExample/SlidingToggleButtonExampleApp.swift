//
//  SlidingToggleButtonExampleApp.swift
//  SlidingToggleButtonExample
//
//  Created by Taha Tesser on 25.12.2024.
//

import SwiftUI

@main
struct SlidingToggleButtonExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .containerBackground(.thinMaterial, for: .window)
                .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        }
        .windowStyle(.hiddenTitleBar)
        .windowBackgroundDragBehavior(.enabled)
    }
}
