import SwiftUI
import Testing
@testable import SlidingToggleButton

@Suite("SlidingToggleButton Benchmark Tests")
struct SlidingToggleButtonBenchmarkTests {

    @Test("Benchmark: First Render Time")
    func benchmarkFirstRenderTime() {
        var value = false
        let binding = Binding(get: { value }, set: { value = $0 })

        let startTime = CFAbsoluteTimeGetCurrent()
        let button = SlidingToggleButton(value: binding) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        _ = button.body
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsed = (endTime - startTime) * 1000

        print("First Render Time: \(String(format: "%.3f", elapsed))ms")
        #expect(elapsed < 16.67, "First render should complete within one frame (16.67ms at 60fps)")
    }

    @Test("Benchmark: View Hierarchy Depth")
    func benchmarkViewHierarchyDepth() {
        var value = false
        let binding = Binding(get: { value }, set: { value = $0 })

        let button = SlidingToggleButton(value: binding) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }

        let bodyDescription = String(describing: button.body)
        let depth = bodyDescription.components(separatedBy: "(").count - 1

        print("View Hierarchy Depth: \(depth) levels")
        #expect(depth < 250, "View hierarchy should not be excessively deep")
    }

    @Test("Benchmark: Memory Footprint")
    func benchmarkMemoryFootprint() {
        let instanceSize = MemoryLayout<SlidingToggleButton<Image, Image>>.size
        let instanceStride = MemoryLayout<SlidingToggleButton<Image, Image>>.stride
        let instanceAlignment = MemoryLayout<SlidingToggleButton<Image, Image>>.alignment

        print("Instance Size: \(instanceSize) bytes")
        print("Instance Stride: \(instanceStride) bytes")
        print("Instance Alignment: \(instanceAlignment) bytes")

        #expect(instanceSize < 512, "Instance should be under 512 bytes")
    }

    @Test("Benchmark: State Toggle Latency")
    func benchmarkStateToggleLatency() {
        var value = false
        let binding = Binding(get: { value }, set: { value = $0 })

        let button = SlidingToggleButton(value: binding) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        _ = button.body

        let startTime = CFAbsoluteTimeGetCurrent()
        value = true
        _ = button.body
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsed = (endTime - startTime) * 1000

        print("State Toggle Latency: \(String(format: "%.3f", elapsed))ms")
        #expect(elapsed < 16.67, "State toggle should complete within one frame (16.67ms at 60fps)")
    }

    @Test("Benchmark: Rapid Toggle Stability")
    func benchmarkRapidToggleStability() {
        var value = false
        let binding = Binding(get: { value }, set: { value = $0 })

        let button = SlidingToggleButton(value: binding) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }

        let iterations = 1000
        let startTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<iterations {
            value.toggle()
            _ = button.body
        }
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsed = (endTime - startTime) * 1000
        let avgPerToggle = elapsed / Double(iterations)

        print("Rapid Toggle (\(iterations)x): \(String(format: "%.2f", elapsed))ms total")
        print("Average per Toggle: \(String(format: "%.3f", avgPerToggle))ms")
        #expect(avgPerToggle < 1, "Each toggle cycle should be under 1ms")
    }
}
