import SwiftUI

public class SlidingToggleButtonDefaults {
    static let defaultSize: CGFloat = 24
    static let padding: CGFloat = 8
    static let backgroundColor: Color = .secondary.opacity(0.3)
    static let buttonBackgroundColor: Color = .primary.opacity(0.4)
    static let vertical: Bool = false
}

public struct SlidingToggleButton: View {
    @Binding private var value: Bool
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
        value: Binding<Bool>,
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

        _value = value

        if effectiveVertical {
            _buttonAlignment = State(initialValue: value.wrappedValue ? .top : .bottom)
        } else {
            _buttonAlignment = State(initialValue: value.wrappedValue ? .leading : .trailing)
        }

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
                .onChange(of: value) {
                    withAnimation(.spring(response: 0.3)) {
                        switch value {
                        case true:
                            buttonAlignment = vertical ? .top : .leading
                            animateStartIcon.toggle()
                        case false:
                            buttonAlignment = vertical ? .bottom : .trailing
                            animateEndIcon.toggle()
                        }
                        
                    }
                }

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
                            value = true
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
                            value = false
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
        @State private var isDarkMode = true
        @State private var timer: Timer?

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
            .padding()
            .onAppear {
                // Schedule a timer and dispatch toggling back to the main actor
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    Task { @MainActor in
                        isDarkMode.toggle()

                        print(isDarkMode)
                    }
                }
            }
            .onDisappear {
                // Invalidate the timer if you don’t want it to keep firing
                timer?.invalidate()
                timer = nil
            }
        }
    }

    return PreviewWrapper()
}
