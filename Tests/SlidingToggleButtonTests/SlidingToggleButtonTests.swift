import SwiftUI
import Testing
@testable import SlidingToggleButton

@Suite("SlidingToggleButton Tests")
struct SlidingToggleButtonTests {

    // MARK: - Defaults Tests

    @Test("Default values are set correctly")
    func testDefaultValues() {
        #expect(SlidingToggleButtonDefaults.defaultSize == 24)
        #expect(SlidingToggleButtonDefaults.padding == 8)
        #expect(SlidingToggleButtonDefaults.vertical == false)
    }

    // MARK: - Initialization Tests

    @Test("Initialization with minimum parameters")
    func testMinimalInitialization() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(button.size == SlidingToggleButtonDefaults.defaultSize)
        #expect(button.padding == SlidingToggleButtonDefaults.padding)
        #expect(button.vertical == SlidingToggleButtonDefaults.vertical)
        #expect(button.startIconName == "sun.max.fill")
        #expect(button.endIconName == "moon.fill")
    }

    @Test("Initialization with custom size")
    func testCustomSizeInitialization() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            size: 32,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(button.size == 32)
    }

    @Test("Initialization with custom padding")
    func testCustomPaddingInitialization() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            padding: 12,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(button.padding == 12)
    }

    @Test("Initialization with vertical orientation")
    func testVerticalInitialization() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            vertical: true,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(button.vertical == true)
    }

    @Test("Initialization with custom background color")
    func testCustomBackgroundColorInitialization() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            backgroundColor: .red,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(button.backgroundColor == .red)
    }

    @Test("Initialization with custom button background color")
    func testCustomButtonBackgroundColorInitialization() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            buttonBackgroundColor: .blue,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(button.buttonBackgroundColor == .blue)
    }

    @Test("Initialization with all custom parameters")
    func testFullCustomInitialization() {
        var value = true
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            size: 48,
            padding: 16,
            backgroundColor: .green,
            buttonBackgroundColor: .orange,
            vertical: true,
            startIconName: "star.fill",
            endIconName: "heart.fill"
        )
        #expect(button.size == 48)
        #expect(button.padding == 16)
        #expect(button.backgroundColor == .green)
        #expect(button.buttonBackgroundColor == .orange)
        #expect(button.vertical == true)
        #expect(button.startIconName == "star.fill")
        #expect(button.endIconName == "heart.fill")
    }

    // MARK: - Initial State Tests

    @Test("Horizontal button initial alignment when value is true")
    func testHorizontalInitialAlignmentTrue() {
        var value = true
        _ = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(value == true)
    }

    @Test("Horizontal button initial alignment when value is false")
    func testHorizontalInitialAlignmentFalse() {
        var value = false
        _ = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(value == false)
    }

    @Test("Vertical button initial alignment when value is true")
    func testVerticalInitialAlignmentTrue() {
        var value = true
        _ = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            vertical: true,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(value == true)
    }

    @Test("Vertical button initial alignment when value is false")
    func testVerticalInitialAlignmentFalse() {
        var value = false
        _ = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            vertical: true,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(value == false)
    }

    // MARK: - Body Generation Tests

    @Test("Body generates View for horizontal configuration")
    func testHorizontalBodyGeneration() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        let _ = button.body
        #expect(button.vertical == false)
    }

    @Test("Body generates View for vertical configuration")
    func testVerticalBodyGeneration() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            vertical: true,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        let _ = button.body
        #expect(button.vertical == true)
    }

    // MARK: - Edge Cases

    @Test("Initialization with zero size")
    func testZeroSizeInitialization() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            size: 0,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(button.size == 0)
    }

    @Test("Initialization with zero padding")
    func testZeroPaddingInitialization() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            padding: 0,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(button.padding == 0)
    }

    @Test("Initialization with large size")
    func testLargeSizeInitialization() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            size: 1000,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )
        #expect(button.size == 1000)
    }

    @Test("Different icon names are stored correctly")
    func testDifferentIconNames() {
        var value = false
        let button = SlidingToggleButton(
            value: .init(get: { value }, set: { value = $0 }),
            startIconName: "play.fill",
            endIconName: "pause.fill"
        )
        #expect(button.startIconName == "play.fill")
        #expect(button.endIconName == "pause.fill")
    }
}
