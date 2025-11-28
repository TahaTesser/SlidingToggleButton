import SwiftUI
import Testing
@testable import SlidingToggleButton

@Suite("SlidingToggleButton Benchmark Tests")
struct SlidingToggleButtonBenchmarkTests {

    @Test("First Render Time (2-Icon and 3-Icon)")
    func benchmarkFirstRenderTime() {
        var selection = 0
        let binding = Binding(get: { selection }, set: { selection = $0 })

        // 2-Icon
        let startTime2 = CFAbsoluteTimeGetCurrent()
        let twoIcon = SlidingToggleButton(selection: binding) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        _ = twoIcon.body
        let elapsed2 = (CFAbsoluteTimeGetCurrent() - startTime2) * 1000
        print("2-Icon First Render: \(String(format: "%.3f", elapsed2))ms")
        #expect(elapsed2 < 16.67)

        // 3-Icon
        let startTime3 = CFAbsoluteTimeGetCurrent()
        let threeIcon = SlidingToggleButton(selection: binding) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        _ = threeIcon.body
        let elapsed3 = (CFAbsoluteTimeGetCurrent() - startTime3) * 1000
        print("3-Icon First Render: \(String(format: "%.3f", elapsed3))ms")
        #expect(elapsed3 < 16.67)
    }

    @Test("Memory Footprint")
    func benchmarkMemoryFootprint() {
        let size = MemoryLayout<SlidingToggleButton>.size
        let stride = MemoryLayout<SlidingToggleButton>.stride
        let alignment = MemoryLayout<SlidingToggleButton>.alignment

        print("Instance Size: \(size) bytes")
        print("Instance Stride: \(stride) bytes")
        print("Instance Alignment: \(alignment) bytes")

        #expect(size < 512)
    }

    @Test("State Toggle Latency (2-Icon and 3-Icon)")
    func benchmarkStateToggleLatency() {
        var selection = 0
        let binding = Binding(get: { selection }, set: { selection = $0 })

        // 2-Icon
        let twoIcon = SlidingToggleButton(selection: binding) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }
        _ = twoIcon.body

        let startTime2 = CFAbsoluteTimeGetCurrent()
        selection = 1
        _ = twoIcon.body
        let elapsed2 = (CFAbsoluteTimeGetCurrent() - startTime2) * 1000
        print("2-Icon Toggle Latency: \(String(format: "%.3f", elapsed2))ms")
        #expect(elapsed2 < 16.67)

        // 3-Icon
        selection = 0
        let threeIcon = SlidingToggleButton(selection: binding) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }
        _ = threeIcon.body

        let startTime3 = CFAbsoluteTimeGetCurrent()
        selection = 2
        _ = threeIcon.body
        let elapsed3 = (CFAbsoluteTimeGetCurrent() - startTime3) * 1000
        print("3-Icon Toggle Latency: \(String(format: "%.3f", elapsed3))ms")
        #expect(elapsed3 < 16.67)
    }

    @Test("Rapid Toggle Stability (2-Icon and 3-Icon)")
    func benchmarkRapidToggleStability() {
        var selection = 0
        let binding = Binding(get: { selection }, set: { selection = $0 })
        let iterations = 1000

        // 2-Icon
        let twoIcon = SlidingToggleButton(selection: binding) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "moon.fill")
        }

        let startTime2 = CFAbsoluteTimeGetCurrent()
        for i in 0..<iterations {
            selection = i % 2
            _ = twoIcon.body
        }
        let elapsed2 = (CFAbsoluteTimeGetCurrent() - startTime2) * 1000
        let avg2 = elapsed2 / Double(iterations)
        let msg2 = "2-Icon Rapid (\(iterations)x): \(String(format: "%.2f", elapsed2))ms"
        print("\(msg2), avg: \(String(format: "%.3f", avg2))ms")
        #expect(avg2 < 1)

        // 3-Icon
        let threeIcon = SlidingToggleButton(selection: binding) {
            Image(systemName: "sun.max.fill")
            Image(systemName: "circle.lefthalf.filled")
            Image(systemName: "moon.fill")
        }

        let startTime3 = CFAbsoluteTimeGetCurrent()
        for i in 0..<iterations {
            selection = i % 3
            _ = threeIcon.body
        }
        let elapsed3 = (CFAbsoluteTimeGetCurrent() - startTime3) * 1000
        let avg3 = elapsed3 / Double(iterations)
        let msg3 = "3-Icon Rapid (\(iterations)x): \(String(format: "%.2f", elapsed3))ms"
        print("\(msg3), avg: \(String(format: "%.3f", avg3))ms")
        #expect(avg3 < 1)
    }
}
