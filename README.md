#  SlidingToggleButton

A minimal sliding toggle button SwiftUI Swift Package library.

## Specifications

![SlidingToggleButton_Specs.png](.//Docs/SlidingToggleButton_Specs.png)

## Measurements (Horizontal)

![SlidingToggleButton_Horizontal_Measurements.png](.//Docs/SlidingToggleButton_Horizontal_Measurements.png)

## Measurements (Vertical)

![SlidingToggleButton_Vertical_Measurements.png](.//Docs/SlidingToggleButton_Vertical_Measurements.png)

## Colors

![SlidingToggleButton_Colors.png](.//Docs/SlidingToggleButton_Colors.png)

## Installation

You can add SlidingToggleButton to your project via Swift Package Manager:
1. Open your project in Xcode.
2. Navigate to File > Add Package Dependencies.
3. Enter the following URL:

```
https://github.com/TahaTesser/SlidingToggleButton.git
```

## Example Usage

```swift
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

## Licence

**SlidingToggleButton** is available under the MIT licence. See the [LICENCE](./LICENSE) for more info.
