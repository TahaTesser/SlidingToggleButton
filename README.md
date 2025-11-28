# SlidingToggleButton

A minimal sliding SwiftUI toggle button with support for 2 or 3 states.

https://github.com/user-attachments/assets/5ce70903-8e6a-40a8-a2c2-40c88b513571

## Installation

Add SlidingToggleButton to your project via Swift Package Manager:

1. Open your project in Xcode
2. Navigate to **File > Add Package Dependencies**
3. Enter the following URL:

```
https://github.com/TahaTesser/SlidingToggleButton.git
```

## Usage

```swift
import SlidingToggleButton

struct ContentView: View {
    @State private var twoIconSelection = 0
    @State private var threeIconSelection = 0

    var body: some View {
        VStack {
            // 2-Icon Toggle
            SlidingToggleButton(selection: $twoIconSelection) {
                Image(systemName: "sun.max.fill")
                Image(systemName: "moon.fill")
            }
            
            // 3-Icon Toggle
            SlidingToggleButton(selection: $threeIconSelection) {
                Image(systemName: "sun.max.fill")
                Image(systemName: "circle.lefthalf.filled")
                Image(systemName: "moon.fill")
            }
        }
    }
}
```

Selection values: `0` (start), `1` (center for 3-icon), `2` (end for 3-icon)

### Customization

```swift
SlidingToggleButton(
    selection: $selection,
    size: 32,
    padding: 12,
    backgroundColor: .blue.opacity(0.3),
    buttonBackgroundColor: .blue.opacity(0.6),
    vertical: true
) {
    Image(systemName: "sun.max.fill")
    Image(systemName: "moon.fill")
}
```

## Requirements

| Platform | Minimum Version |
|----------|-----------------|
| iOS | 17.0+ |
| macOS | 14.0+ |

**Swift Version:** 5.9+ (Swift 6 compatible)

## Performance

| Metric | 2-Icon | 3-Icon |
|--------|--------|--------|
| First Render | 0.48ms | 0.50ms |
| State Toggle | 0.03ms | 0.02ms |
| Memory | 96 bytes | 96 bytes |

Optimized for 60fps rendering. See [Benchmark Results](./Docs/BenchmarkResults.md) for details.

## License

**SlidingToggleButton** is available under the MIT license. See the [LICENSE](./LICENSE.md) for more info.
