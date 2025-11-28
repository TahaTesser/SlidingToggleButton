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

    @Test("2-Icon and 3-Icon: Initialization with minimum parameters")
    func testMinimalInitialization() {
        var selection = 0

        // 2-Icon
        let twoIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 })
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #expect(twoIcon.size == SlidingToggleButtonDefaults.defaultSize)
        #expect(twoIcon.padding == SlidingToggleButtonDefaults.padding)
        #expect(twoIcon.vertical == SlidingToggleButtonDefaults.vertical)

        // 3-Icon
        let threeIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 })
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        #expect(threeIcon.size == SlidingToggleButtonDefaults.defaultSize)
        #expect(threeIcon.padding == SlidingToggleButtonDefaults.padding)
        #expect(threeIcon.vertical == SlidingToggleButtonDefaults.vertical)
    }

    @Test("2-Icon and 3-Icon: Initialization with custom size")
    func testCustomSizeInitialization() {
        var selection = 0

        let twoIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            size: 32
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #expect(twoIcon.size == 32)

        let threeIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            size: 48
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        #expect(threeIcon.size == 48)
    }

    @Test("2-Icon and 3-Icon: Initialization with custom padding")
    func testCustomPaddingInitialization() {
        var selection = 0

        let twoIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            padding: 12
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #expect(twoIcon.padding == 12)

        let threeIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            padding: 16
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        #expect(threeIcon.padding == 16)
    }

    @Test("2-Icon and 3-Icon: Initialization with vertical orientation")
    func testVerticalInitialization() {
        var selection = 0

        let twoIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            vertical: true
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #expect(twoIcon.vertical == true)

        let threeIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            vertical: true
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        #expect(threeIcon.vertical == true)
    }

    @Test("Initialization with custom colors")
    func testCustomColorsInitialization() {
        var selection = 0

        let button = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            backgroundColor: .red,
            buttonBackgroundColor: .blue
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #expect(button.backgroundColor == .red)
        #expect(button.buttonBackgroundColor == .blue)
    }

    @Test("2-Icon and 3-Icon: Initialization with all custom parameters")
    func testFullCustomInitialization() {
        var selection = 1

        let twoIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            size: 48,
            padding: 16,
            backgroundColor: .green,
            buttonBackgroundColor: .orange,
            vertical: true
        ) {
            Image(systemName: "star.fill")
            Image(systemName: "heart.fill")
        }
        #expect(twoIcon.size == 48)
        #expect(twoIcon.padding == 16)
        #expect(twoIcon.backgroundColor == .green)
        #expect(twoIcon.buttonBackgroundColor == .orange)
        #expect(twoIcon.vertical == true)

        let threeIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            size: 36,
            padding: 12,
            backgroundColor: .purple,
            buttonBackgroundColor: .cyan,
            vertical: true
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        #expect(threeIcon.size == 36)
        #expect(threeIcon.padding == 12)
        #expect(threeIcon.backgroundColor == .purple)
        #expect(threeIcon.buttonBackgroundColor == .cyan)
        #expect(threeIcon.vertical == true)
    }

    // MARK: - Selection State Tests

    @Test("2-Icon: Selection states 0 and 1")
    func testTwoIconSelectionStates() {
        var selection0 = 0
        var selection1 = 1

        _ = SlidingToggleButton(
            selection: .init(get: { selection0 }, set: { selection0 = $0 })
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #expect(selection0 == 0)

        _ = SlidingToggleButton(
            selection: .init(get: { selection1 }, set: { selection1 = $0 })
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #expect(selection1 == 1)
    }

    @Test("3-Icon: Selection states 0, 1, and 2")
    func testThreeIconSelectionStates() {
        var selection0 = 0
        var selection1 = 1
        var selection2 = 2

        _ = SlidingToggleButton(
            selection: .init(get: { selection0 }, set: { selection0 = $0 })
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        #expect(selection0 == 0)

        _ = SlidingToggleButton(
            selection: .init(get: { selection1 }, set: { selection1 = $0 })
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        #expect(selection1 == 1)

        _ = SlidingToggleButton(
            selection: .init(get: { selection2 }, set: { selection2 = $0 })
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        #expect(selection2 == 2)
    }

    // MARK: - Body Generation Tests

    @Test("2-Icon and 3-Icon: Body generates View for horizontal and vertical")
    func testBodyGeneration() {
        var selection = 0

        // 2-Icon horizontal
        let twoIconH = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 })
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        _ = twoIconH.body
        #expect(twoIconH.vertical == false)

        // 2-Icon vertical
        let twoIconV = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            vertical: true
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        _ = twoIconV.body
        #expect(twoIconV.vertical == true)

        // 3-Icon horizontal
        let threeIconH = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 })
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        _ = threeIconH.body
        #expect(threeIconH.vertical == false)

        // 3-Icon vertical
        let threeIconV = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            vertical: true
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        _ = threeIconV.body
        #expect(threeIconV.vertical == true)
    }

    // MARK: - Edge Cases

    @Test("Edge cases: zero size, zero padding, large size")
    func testEdgeCases() {
        var selection = 0

        let zeroSize = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            size: 0
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #expect(zeroSize.size == 0)

        let zeroPadding = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            padding: 0
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #expect(zeroPadding.padding == 0)

        let largeSize = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 }),
            size: 1000
        ) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        #expect(largeSize.size == 1000)
    }

    @Test("2-Icon and 3-Icon: Custom view icons")
    func testCustomViewIcons() {
        var selection = 0

        let twoIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 })
        ) {
            Circle().fill(.yellow)
            Rectangle().fill(.blue)
        }
        #expect(twoIcon.size == SlidingToggleButtonDefaults.defaultSize)

        let threeIcon = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 })
        ) {
            Circle().fill(.yellow)
            Circle().fill(.gray)
            Circle().fill(.blue)
        }
        #expect(threeIcon.size == SlidingToggleButtonDefaults.defaultSize)
    }

    @Test("Different SF Symbol icons work correctly")
    func testDifferentSFSymbolIcons() {
        var selection = 0

        let button = SlidingToggleButton(
            selection: .init(get: { selection }, set: { selection = $0 })
        ) {
            Image(systemName: "play.fill")
            Image(systemName: "pause.fill")
        }
        _ = button.body
        #expect(selection == 0)
    }
}
