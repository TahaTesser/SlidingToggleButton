import SnapshotTesting
import SwiftUI
import Testing
@testable import SlidingToggleButton

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// Set to true to record new snapshots
let isRecording = false

// MARK: - Snapshot Tests

@Suite("SlidingToggleButton Snapshot Tests")
@MainActor
struct SnapshotTests {

    // MARK: - 2-Icon Tests

    @Test("2-Icon: Horizontal selections")
    func testTwoIconHorizontal() {
        for selection in [0, 1] {
            let view = TwoIconWrapper(selection: selection)
            let name = "selection-\(selection)"
            #if os(iOS)
            assertSnapshot(of: view, as: .image(layout: .sizeThatFits), named: name, record: isRecording)
            #elseif os(macOS)
            let hostingView = NSHostingView(rootView: view)
            hostingView.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
            assertSnapshot(of: hostingView, as: .image, named: name, record: isRecording)
            #endif
        }
    }

    @Test("2-Icon: Vertical selections")
    func testTwoIconVertical() {
        for selection in [0, 1] {
            let view = TwoIconWrapper(selection: selection, vertical: true)
            let name = "selection-\(selection)"
            #if os(iOS)
            assertSnapshot(of: view, as: .image(layout: .sizeThatFits), named: name, record: isRecording)
            #elseif os(macOS)
            let hostingView = NSHostingView(rootView: view)
            hostingView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
            assertSnapshot(of: hostingView, as: .image, named: name, record: isRecording)
            #endif
        }
    }

    // MARK: - 3-Icon Tests

    @Test("3-Icon: Horizontal selections")
    func testThreeIconHorizontal() {
        for selection in [0, 1, 2] {
            let view = ThreeIconWrapper(selection: selection)
            let name = "selection-\(selection)"
            #if os(iOS)
            assertSnapshot(of: view, as: .image(layout: .sizeThatFits), named: name, record: isRecording)
            #elseif os(macOS)
            let hostingView = NSHostingView(rootView: view)
            hostingView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
            assertSnapshot(of: hostingView, as: .image, named: name, record: isRecording)
            #endif
        }
    }

    @Test("3-Icon: Vertical selections")
    func testThreeIconVertical() {
        for selection in [0, 1, 2] {
            let view = ThreeIconWrapper(selection: selection, vertical: true)
            let name = "selection-\(selection)"
            #if os(iOS)
            assertSnapshot(of: view, as: .image(layout: .sizeThatFits), named: name, record: isRecording)
            #elseif os(macOS)
            let hostingView = NSHostingView(rootView: view)
            hostingView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
            assertSnapshot(of: hostingView, as: .image, named: name, record: isRecording)
            #endif
        }
    }

    // MARK: - Customization Tests

    @Test("Custom size and padding")
    func testCustomSizeAndPadding() {
        let view = TwoIconWrapper(selection: 0, size: 48, padding: 16)
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 220, height: 150)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Custom colors")
    func testCustomColors() {
        let view = TwoIconWrapper(
            selection: 0,
            backgroundColor: .blue.opacity(0.3),
            buttonBackgroundColor: .red.opacity(0.5)
        )
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    // MARK: - Programmatic Update Tests

    @Test("Programmatic selection update")
    func testProgrammaticUpdate() {
        // Test that programmatic selection changes position the button correctly
        // This verifies the fix for animated state updates
        for targetSelection in [0, 1, 2] {
            let view = ProgrammaticUpdateWrapper(initialSelection: 0, targetSelection: targetSelection)
            let name = "target-\(targetSelection)"
            #if os(iOS)
            assertSnapshot(of: view, as: .image(layout: .sizeThatFits), named: name, record: isRecording)
            #elseif os(macOS)
            let hostingView = NSHostingView(rootView: view)
            hostingView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
            assertSnapshot(of: hostingView, as: .image, named: name, record: isRecording)
            #endif
        }
    }

    // MARK: - Combined View Test

    @Test("2-Icon and 3-Icon side by side")
    func testCombinedView() {
        struct CombinedView: View {
            @State var twoIcon = 0
            @State var threeIcon = 1

            var body: some View {
                HStack(spacing: 20) {
                    SlidingToggleButton(selection: $twoIcon) {
                        Image(systemName: "sun.max.fill")
                        Image(systemName: "moon.fill")
                    }
                    SlidingToggleButton(selection: $threeIcon) {
                        Image(systemName: "sun.max.fill")
                        Image(systemName: "circle.lefthalf.filled")
                        Image(systemName: "moon.fill")
                    }
                }
                .padding(20)
                .background(Color.gray.opacity(0.2))
            }
        }

        let view = CombinedView()
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }
}

// MARK: - Test Wrappers

private struct TwoIconWrapper: View {
    @State var selection: Int
    var size: CGFloat?
    var padding: CGFloat?
    var backgroundColor: Color?
    var buttonBackgroundColor: Color?
    var vertical: Bool

    init(
        selection: Int = 0,
        size: CGFloat? = nil,
        padding: CGFloat? = nil,
        backgroundColor: Color? = nil,
        buttonBackgroundColor: Color? = nil,
        vertical: Bool = false
    ) {
        self._selection = State(initialValue: selection)
        self.size = size
        self.padding = padding
        self.backgroundColor = backgroundColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.vertical = vertical
    }

    var body: some View {
        SlidingToggleButton(
            selection: $selection,
            size: size,
            padding: padding,
            backgroundColor: backgroundColor,
            buttonBackgroundColor: buttonBackgroundColor,
            vertical: vertical
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
    }
}

private struct ThreeIconWrapper: View {
    @State var selection: Int
    var vertical: Bool

    init(selection: Int = 0, vertical: Bool = false) {
        self._selection = State(initialValue: selection)
        self.vertical = vertical
    }

    var body: some View {
        SlidingToggleButton(selection: $selection, vertical: vertical) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
    }
}

private struct ProgrammaticUpdateWrapper: View {
    @State var selection: Int
    let targetSelection: Int

    init(initialSelection: Int, targetSelection: Int) {
        self._selection = State(initialValue: initialSelection)
        self.targetSelection = targetSelection
    }

    var body: some View {
        SlidingToggleButton(selection: $selection) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
        .onAppear {
            // Programmatically update selection (simulates external state change)
            selection = targetSelection
        }
    }
}
