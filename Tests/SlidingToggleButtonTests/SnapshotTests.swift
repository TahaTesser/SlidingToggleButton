import SnapshotTesting
import SwiftUI
import Testing
@testable import SlidingToggleButton

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// MARK: - Test Wrapper

struct SnapshotTestWrapper<StartIcon: View, EndIcon: View>: View {
    @State var value: Bool
    let size: CGFloat?
    let padding: CGFloat?
    let backgroundColor: Color?
    let buttonBackgroundColor: Color?
    let vertical: Bool
    let startIcon: StartIcon
    let endIcon: EndIcon

    init(
        value: Bool = false,
        size: CGFloat? = nil,
        padding: CGFloat? = nil,
        backgroundColor: Color? = nil,
        buttonBackgroundColor: Color? = nil,
        vertical: Bool = false,
        @ViewBuilder icons: () -> TupleView<(StartIcon, EndIcon)>
    ) {
        self._value = State(initialValue: value)
        self.size = size
        self.padding = padding
        self.backgroundColor = backgroundColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.vertical = vertical
        let iconViews = icons().value
        self.startIcon = iconViews.0
        self.endIcon = iconViews.1
    }

    var body: some View {
        SlidingToggleButton(
            value: $value,
            size: size,
            padding: padding,
            backgroundColor: backgroundColor,
            buttonBackgroundColor: buttonBackgroundColor,
            vertical: vertical
        ) {
            startIcon
            endIcon
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
    }
}

// Set to true to record new snapshots
let isRecording = false

// MARK: - Horizontal Snapshot Tests

@Suite("SlidingToggleButton Horizontal Snapshot Tests")
@MainActor
struct HorizontalSnapshotTests {

    @Test("Horizontal - Default - Value False")
    func testHorizontalDefaultFalse() {
        let view = SnapshotTestWrapper(value: false) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Horizontal - Default - Value True")
    func testHorizontalDefaultTrue() {
        let view = SnapshotTestWrapper(value: true) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Horizontal - Custom Size")
    func testHorizontalCustomSize() {
        let view = SnapshotTestWrapper(value: false, size: 48) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Horizontal - Custom Padding")
    func testHorizontalCustomPadding() {
        let view = SnapshotTestWrapper(value: false, padding: 16) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 180, height: 120)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Horizontal - Custom Colors")
    func testHorizontalCustomColors() {
        let view = SnapshotTestWrapper(
            value: false,
            backgroundColor: .blue.opacity(0.3),
            buttonBackgroundColor: .red.opacity(0.5)
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }
}

// MARK: - Vertical Snapshot Tests

@Suite("SlidingToggleButton Vertical Snapshot Tests")
@MainActor
struct VerticalSnapshotTests {

    @Test("Vertical - Default - Value False")
    func testVerticalDefaultFalse() {
        let view = SnapshotTestWrapper(value: false, vertical: true) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Vertical - Default - Value True")
    func testVerticalDefaultTrue() {
        let view = SnapshotTestWrapper(value: true, vertical: true) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Vertical - Custom Size")
    func testVerticalCustomSize() {
        let view = SnapshotTestWrapper(value: false, size: 48, vertical: true) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 150, height: 200)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Vertical - Custom Padding")
    func testVerticalCustomPadding() {
        let view = SnapshotTestWrapper(value: false, padding: 16, vertical: true) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 120, height: 180)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Vertical - Custom Colors")
    func testVerticalCustomColors() {
        let view = SnapshotTestWrapper(
            value: false,
            backgroundColor: .green.opacity(0.3),
            buttonBackgroundColor: .purple.opacity(0.5),
            vertical: true
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }
}

// MARK: - Combined Snapshot Tests

@Suite("SlidingToggleButton Combined Snapshot Tests")
@MainActor
struct CombinedSnapshotTests {

    @Test("Horizontal and Vertical Side by Side")
    func testHorizontalAndVerticalSideBySide() {
        struct CombinedView: View {
            @State var value = false

            var body: some View {
                HStack(spacing: 20) {
                    SlidingToggleButton(value: $value) {
                        Image(systemName: "sun.max.fill")
                        Image(systemName: "moon.fill")
                    }
                    SlidingToggleButton(value: $value, vertical: true) {
                        Image(systemName: "sun.max.fill")
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
        hostingView.frame = CGRect(x: 0, y: 0, width: 250, height: 150)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Full Custom Configuration")
    func testFullCustomConfiguration() {
        let view = SnapshotTestWrapper(
            value: true,
            size: 36,
            padding: 12,
            backgroundColor: .orange.opacity(0.3),
            buttonBackgroundColor: .cyan.opacity(0.5),
            vertical: false
        ) {
            Image(systemName: "play.fill")
            Image(systemName: "pause.fill")
        }
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 200, height: 120)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Different Icons Configuration")
    func testDifferentIconsConfiguration() {
        struct IconsView: View {
            @State var value = false

            var body: some View {
                VStack(spacing: 20) {
                    SlidingToggleButton(value: $value) {
                        Image(systemName: "sun.max.fill")
                        Image(systemName: "moon.fill")
                    }
                    SlidingToggleButton(value: $value) {
                        Image(systemName: "play.fill")
                        Image(systemName: "pause.fill")
                    }
                    SlidingToggleButton(value: $value) {
                        Image(systemName: "speaker.wave.3.fill")
                        Image(systemName: "speaker.slash.fill")
                    }
                }
                .padding(20)
                .background(Color.gray.opacity(0.2))
            }
        }

        let view = IconsView()
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 200, height: 250)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    @Test("Custom View Icons")
    func testCustomViewIcons() {
        struct CustomIconsView: View {
            @State var value = false

            var body: some View {
                SlidingToggleButton(value: $value) {
                    Circle().fill(.yellow)
                    Circle().fill(.blue)
                }
                .padding(20)
                .background(Color.gray.opacity(0.2))
            }
        }

        let view = CustomIconsView()
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }
}
