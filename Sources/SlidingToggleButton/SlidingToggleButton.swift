import SwiftUI

public class SlidingToggleButtonDefaults {
    static let defaultSize: CGFloat = 32
    static let padding: CGFloat = 8
    static let backgroundColor: Color = .secondary.opacity(0.3)
    static let buttonBackgroundColor: Color = .primary.opacity(0.44)
    static let vertical: Bool = false
}

public struct SlidingToggleButton: View {
    @Binding var isToggled: Bool

    @State private var buttonAlignment: Alignment
    @State private var animateStartIcon: Bool = false
    @State private var animateEndIcon: Bool = false

    let size: CGFloat
    let padding: CGFloat
    let backgroundColor: Color
    let buttonBackgroundColor: Color
    let vertical: Bool
    let startIconName: String
    let endIconName: String

    public init(
        isToggled: Binding<Bool>,
        size: CGFloat? = nil,
        padding: CGFloat? = nil,
        backgroundColor: Color? = nil,
        buttonBackgroundColor: Color? = nil,
        vertical: Bool? = nil,
        startIconName: String,
        endIconName: String
    ) {
        let effectiveSize = size ?? SlidingToggleButtonDefaults.defaultSize
        let effectiveVertical = vertical ?? SlidingToggleButtonDefaults.vertical
        let effectivePadding = padding ?? SlidingToggleButtonDefaults.padding

        if effectiveVertical {
            _buttonAlignment = State(initialValue: .top)
        } else {
            _buttonAlignment = State(initialValue: .leading)
        }

        _isToggled = isToggled
        self.size = effectiveSize
        self.padding = effectivePadding
        self.backgroundColor = backgroundColor ?? SlidingToggleButtonDefaults.backgroundColor
        self.buttonBackgroundColor = buttonBackgroundColor ?? SlidingToggleButtonDefaults.buttonBackgroundColor
        self.vertical = effectiveVertical
        self.startIconName = startIconName
        self.endIconName = endIconName
    }

    public var body: some View {
        ZStack(alignment: buttonAlignment) {
            Circle()
                .fill(buttonBackgroundColor)
                .frame(
                    width: size + (padding * 2),
                    height: size + (padding * 2)
                )
                .animation(.spring(response: 0.3), value: isToggled)

            flexibleStack(vertical: vertical, spacing: 0) {
                Image(systemName: startIconName)
                    .resizable()
                    .frame(width: size, height: size)
                    .padding(padding)
                    .foregroundStyle(.white)
                    .containerShape(.rect)
                    .phaseAnimator([false, true], trigger: animateStartIcon) { sparkleSymbol, _ in
                        sparkleSymbol
                            .symbolEffect(.bounce.byLayer, value: animateStartIcon)
                    }

                    .onTapGesture {
                        withAnimation(.spring(response: 0.3)) {
                            if vertical {
                                buttonAlignment = .top
                            } else {
                                buttonAlignment = .leading
                            }
                            animateStartIcon.toggle()
                            isToggled = true
                        }
                    }

                Image(systemName: endIconName)
                    .resizable()
                    .frame(width: size, height: size)
                    .padding(padding)
                    .foregroundStyle(.white)
                    .containerShape(.rect)
                    .phaseAnimator([false, true], trigger: animateEndIcon) { sparkleSymbol, _ in
                        sparkleSymbol
                            .symbolEffect(.bounce.byLayer, value: animateEndIcon)
                    }

                    .onTapGesture {
                        withAnimation(.spring(response: 0.3)) {
                            if vertical {
                                buttonAlignment = .bottom
                            } else {
                                buttonAlignment = .trailing
                            }
                            animateEndIcon.toggle()
                            isToggled = false
                        }
                    }
            }
        }
        .background(
            Capsule()
                .fill(backgroundColor)
        )
    }

    @ViewBuilder
    func flexibleStack<Content: View>(
        vertical: Bool,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) -> some View {
        if vertical {
            VStack(spacing: spacing, content: content)
        } else {
            HStack(spacing: spacing, content: content)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    struct PreviewWrapper: View {
        @State private var isDarkMode = false

        var body: some View {
            HStack {
                // Horizontal Sliding Toggle Button
                SlidingToggleButton(
                    isToggled: $isDarkMode,
                    size: 20,
                    startIconName: "sun.max.fill",
                    endIconName: "moon.fill"
                )
                // Vertical Sliding Toggle Button
                SlidingToggleButton(
                    isToggled: $isDarkMode,
                    size: 20,
                    vertical: true,
                    startIconName: "sun.max.fill",
                    endIconName: "moon.fill"
                )
            }
            .padding()
        }
    }

    return PreviewWrapper()
}
