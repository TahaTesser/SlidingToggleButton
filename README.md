# SlidingToggleButton

A minimal sliding SwiftUI toggle button.

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
    @State private var isDarkMode = false

    var body: some View {
        HStack {
            // Horizontal Sliding Toggle Button
            SlidingToggleButton(
                value: $isDarkMode,
                startIconName: "sun.max.fill",
                endIconName: "moon.fill"
            )
            // Vertical Sliding Toggle Button
            SlidingToggleButton(
                value: $isDarkMode,
                vertical: true,
                startIconName: "sun.max.fill",
                endIconName: "moon.fill"
            )
        }
    }
}
```

## Requirements

| Platform | Minimum Version |
|----------|-----------------|
| iOS | 17.0+ |
| macOS | 14.0+ |

**Swift Version:** 5.9+ (Swift 6 compatible)

### API Dependencies

The following iOS 17+/macOS 14+ APIs are used:
- `phaseAnimator` - For icon bounce animations
- `symbolEffect(.bounce.byLayer)` - For SF Symbol effects
- `containerShape` - For tap gesture shape
- `onChange(of:)` - New simplified syntax

## Specifications

![SlidingToggleButton_Specs.png](./Docs/SlidingToggleButton_Specs.png)

### Measurements (Horizontal)

| Attribute | Value |
|-----------|-------|
| Container Width | 48 pixels |
| Container Height | 24 pixels |
| Button Shape Size | 24 x 24 pixels |
| Icon Size | 18 x 18 pixels |
| Icon Padding | 8 pixels (All Sides) |

### Measurements (Vertical)

| Attribute | Value |
|-----------|-------|
| Container Width | 24 pixels |
| Container Height | 48 pixels |
| Button Shape Size | 24 x 24 pixels |
| Icon Size | 18 x 18 pixels |
| Icon Padding | 8 pixels (All Sides) |

### Colors

| Attribute | Value |
|-----------|-------|
| Container Background Color | `.secondary.opacity(0.3)` |
| Button Background Color | `.primary.opacity(0.4)` |
| Icon Color | `.white` |

## License

**SlidingToggleButton** is available under the MIT license. See the [LICENSE](./LICENSE.md) for more info.
