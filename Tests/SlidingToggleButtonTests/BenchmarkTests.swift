import SwiftUI
import Testing
@testable import SlidingToggleButton

@Suite("SlidingToggleButton Benchmark Tests")
struct SlidingToggleButtonBenchmarkTests {

    // MARK: - Initialization Benchmarks

    @Test("Benchmark: Minimal Initialization (1000 iterations)")
    func benchmarkMinimalInitialization() {
        var value = false
        let binding = Binding(get: { value }, set: { value = $0 })

        let startTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<1000 {
            _ = SlidingToggleButton(
                value: binding,
                startIconName: "sun.max.fill",
                endIconName: "moon.fill"
            )
        }
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsed = (endTime - startTime) * 1000

        print("Minimal Initialization (1000x): \(String(format: "%.2f", elapsed))ms")
        #expect(elapsed < 1000, "Initialization should complete in under 1 second")
    }

    @Test("Benchmark: Full Custom Initialization (1000 iterations)")
    func benchmarkFullCustomInitialization() {
        var value = false
        let binding = Binding(get: { value }, set: { value = $0 })

        let startTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<1000 {
            _ = SlidingToggleButton(
                value: binding,
                size: 48,
                padding: 16,
                backgroundColor: .red,
                buttonBackgroundColor: .blue,
                vertical: true,
                startIconName: "star.fill",
                endIconName: "heart.fill"
            )
        }
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsed = (endTime - startTime) * 1000

        print("Full Custom Initialization (1000x): \(String(format: "%.2f", elapsed))ms")
        #expect(elapsed < 1000, "Initialization should complete in under 1 second")
    }

    @Test("Benchmark: Horizontal vs Vertical Initialization")
    func benchmarkOrientationInitialization() {
        var value = false
        let binding = Binding(get: { value }, set: { value = $0 })

        // Horizontal
        let horizontalStart = CFAbsoluteTimeGetCurrent()
        for _ in 0..<1000 {
            _ = SlidingToggleButton(
                value: binding,
                vertical: false,
                startIconName: "sun.max.fill",
                endIconName: "moon.fill"
            )
        }
        let horizontalEnd = CFAbsoluteTimeGetCurrent()
        let horizontalElapsed = (horizontalEnd - horizontalStart) * 1000

        // Vertical
        let verticalStart = CFAbsoluteTimeGetCurrent()
        for _ in 0..<1000 {
            _ = SlidingToggleButton(
                value: binding,
                vertical: true,
                startIconName: "sun.max.fill",
                endIconName: "moon.fill"
            )
        }
        let verticalEnd = CFAbsoluteTimeGetCurrent()
        let verticalElapsed = (verticalEnd - verticalStart) * 1000

        print("Horizontal Initialization (1000x): \(String(format: "%.2f", horizontalElapsed))ms")
        print("Vertical Initialization (1000x): \(String(format: "%.2f", verticalElapsed))ms")

        #expect(horizontalElapsed < 1000, "Horizontal initialization should complete in under 1 second")
        #expect(verticalElapsed < 1000, "Vertical initialization should complete in under 1 second")
    }

    @Test("Benchmark: State Toggle Binding Updates (10000 iterations)")
    func benchmarkBindingUpdates() {
        var value = false
        let binding = Binding(get: { value }, set: { value = $0 })

        _ = SlidingToggleButton(
            value: binding,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )

        let startTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<10000 {
            value.toggle()
        }
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsed = (endTime - startTime) * 1000

        print("Binding Updates (10000x): \(String(format: "%.2f", elapsed))ms")
        #expect(elapsed < 500, "Binding updates should complete in under 500ms")
    }

    @Test("Benchmark: Body Generation")
    func benchmarkBodyGeneration() {
        var value = false
        let binding = Binding(get: { value }, set: { value = $0 })

        let button = SlidingToggleButton(
            value: binding,
            startIconName: "sun.max.fill",
            endIconName: "moon.fill"
        )

        let startTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<100 {
            _ = button.body
        }
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsed = (endTime - startTime) * 1000

        print("Body Generation (100x): \(String(format: "%.2f", elapsed))ms")
        #expect(elapsed < 1000, "Body generation should complete in under 1 second")
    }

    @Test("Benchmark: Memory - Multiple Instance Creation")
    func benchmarkMultipleInstances() {
        var value = false
        let binding = Binding(get: { value }, set: { value = $0 })

        var buttons: [SlidingToggleButton] = []
        buttons.reserveCapacity(1000)

        let startTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<1000 {
            let button = SlidingToggleButton(
                value: binding,
                startIconName: "sun.max.fill",
                endIconName: "moon.fill"
            )
            buttons.append(button)
        }
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsed = (endTime - startTime) * 1000

        print("Multiple Instance Creation (1000x): \(String(format: "%.2f", elapsed))ms")
        print("Array count: \(buttons.count)")
        #expect(buttons.count == 1000)
        #expect(elapsed < 1000, "Multiple instance creation should complete in under 1 second")
    }

    @Test("Benchmark: Defaults Access")
    func benchmarkDefaultsAccess() {
        let startTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<100000 {
            _ = SlidingToggleButtonDefaults.defaultSize
            _ = SlidingToggleButtonDefaults.padding
            _ = SlidingToggleButtonDefaults.backgroundColor
            _ = SlidingToggleButtonDefaults.buttonBackgroundColor
            _ = SlidingToggleButtonDefaults.vertical
        }
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsed = (endTime - startTime) * 1000

        print("Defaults Access (100000x): \(String(format: "%.2f", elapsed))ms")
        #expect(elapsed < 500, "Defaults access should complete in under 500ms")
    }
}
