import SnapshotTesting
import SwiftUI
import Testing
@testable import SlidingToggleButton

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

@Suite("SlidingToggleButton Snapshot Tests")
@MainActor
struct SlidingToggleButtonSnapshotTests {

    // MARK: - Test Wrapper

    struct TestWrapper: View {
        @State var value: Bool
        let size: CGFloat?
        let padding: CGFloat?
        let backgroundColor: Color?
        let buttonBackgroundColor: Color?
        let vertical: Bool
        let startIconName: String
        let endIconName: String

        init(
            value: Bool = false,
            size: CGFloat? = nil,
            padding: CGFloat? = nil,
            backgroundColor: Color? = nil,
            buttonBackgroundColor: Color? = nil,
            vertical: Bool = false,
            startIconName: String = "sun.max.fill",
            endIconName: String = "moon.fill"
        ) {
            self._value = State(initialValue: value)
            self.size = size
            self.padding = padding
            self.backgroundColor = backgroundColor
            self.buttonBackgroundColor = buttonBackgroundColor
            self.vertical = vertical
            self.startIconName = startIconName
            self.endIconName = endIconName
        }

        var body: some View {
            SlidingToggleButton(
                value: $value,
                size: size,
                padding: padding,
                backgroundColor: backgroundColor,
                buttonBackgroundColor: buttonBackgroundColor,
                vertical: vertical,
                startIconName: startIconName,
                endIconName: endIconName
            )
            .padding(20)
            .background(Color.gray.opacity(0.2))
        }
    }

    // MARK: - Horizontal Configuration Snapshots

    @Test("Horizontal - Default - Value False")
    func testHorizontalDefaultFalse() {
        let view = TestWrapper(value: false)
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
        let view = TestWrapper(value: true)
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
        let view = TestWrapper(value: false, size: 48)
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
        let view = TestWrapper(value: false, padding: 16)
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
        let view = TestWrapper(
            value: false,
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

    // MARK: - Vertical Configuration Snapshots

    @Test("Vertical - Default - Value False")
    func testVerticalDefaultFalse() {
        let view = TestWrapper(value: false, vertical: true)
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
        let view = TestWrapper(value: true, vertical: true)
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
        let view = TestWrapper(value: false, size: 48, vertical: true)
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
        let view = TestWrapper(value: false, padding: 16, vertical: true)
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
        let view = TestWrapper(
            value: false,
            backgroundColor: .green.opacity(0.3),
            buttonBackgroundColor: .purple.opacity(0.5),
            vertical: true
        )
        #if os(iOS)
        assertSnapshot(of: view, as: .image(layout: .sizeThatFits), record: isRecording)
        #elseif os(macOS)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        assertSnapshot(of: hostingView, as: .image, record: isRecording)
        #endif
    }

    // MARK: - Combined Configuration Snapshots

    @Test("Horizontal and Vertical Side by Side")
    func testHorizontalAndVerticalSideBySide() {
        struct CombinedView: View {
            @State var value = false

            var body: some View {
                HStack(spacing: 20) {
                    SlidingToggleButton(
                        value: $value,
                        startIconName: "sun.max.fill",
                        endIconName: "moon.fill"
                    )
                    SlidingToggleButton(
                        value: $value,
                        vertical: true,
                        startIconName: "sun.max.fill",
                        endIconName: "moon.fill"
                    )
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
        let view = TestWrapper(
            value: true,
            size: 36,
            padding: 12,
            backgroundColor: .orange.opacity(0.3),
            buttonBackgroundColor: .cyan.opacity(0.5),
            vertical: false,
            startIconName: "play.fill",
            endIconName: "pause.fill"
        )
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
                    SlidingToggleButton(
                        value: $value,
                        startIconName: "sun.max.fill",
                        endIconName: "moon.fill"
                    )
                    SlidingToggleButton(
                        value: $value,
                        startIconName: "play.fill",
                        endIconName: "pause.fill"
                    )
                    SlidingToggleButton(
                        value: $value,
                        startIconName: "speaker.wave.3.fill",
                        endIconName: "speaker.slash.fill"
                    )
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
}

// Set to true to record new snapshots
private let isRecording = false
