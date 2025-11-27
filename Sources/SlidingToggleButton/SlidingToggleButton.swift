import SwiftUI

// MARK: - Defaults

public class SlidingToggleButtonDefaults {
    public static let defaultSize: CGFloat = 24
    public static let padding: CGFloat = 8
    public static let backgroundColor: Color = .secondary.opacity(0.3)
    public static let buttonBackgroundColor: Color = .primary.opacity(0.4)
    public static let vertical: Bool = false
}

// MARK: - SlidingToggleButton

public struct SlidingToggleButton: View {
    @Binding private var value: Bool
    @State private var buttonAlignment: Alignment
    @State private var animateStartIcon: Bool = false
    @State private var animateEndIcon: Bool = false

    public let size: CGFloat
    public let padding: CGFloat
    public let backgroundColor: Color
    public let buttonBackgroundColor: Color
    public let vertical: Bool
    public let startIconName: String
    public let endIconName: String

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
                startIconView
                endIconView
            }
        }
        .background(
            Capsule()
                .fill(backgroundColor)
        )
    }

    // MARK: - Private Views

    private var startIconView: some View {
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
                handleStartIconTap()
            }
    }

    private var endIconView: some View {
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
                handleEndIconTap()
            }
    }

    // MARK: - Private Methods

    private func handleStartIconTap() {
        withAnimation(.spring(response: 0.3)) {
            buttonAlignment = vertical ? .top : .leading
            animateStartIcon.toggle()
            value = true
        }
    }

    private func handleEndIconTap() {
        withAnimation(.spring(response: 0.3)) {
            buttonAlignment = vertical ? .bottom : .trailing
            animateEndIcon.toggle()
            value = false
        }
    }

    @ViewBuilder
    private func flexibleStack<Content: View>(
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

// MARK: - Preview

#Preview(traits: .sizeThatFitsLayout) {
    struct PreviewWrapper: View {
        @State private var isDarkMode = true
        @State private var timer: Timer?

        var body: some View {
            HStack {
                SlidingToggleButton(
                    value: $isDarkMode,
                    startIconName: "sun.max.fill",
                    endIconName: "moon.fill"
                )
                SlidingToggleButton(
                    value: $isDarkMode,
                    vertical: true,
                    startIconName: "sun.max.fill",
                    endIconName: "moon.fill"
                )
            }
            .padding()
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    Task { @MainActor in
                        isDarkMode.toggle()
                    }
                }
            }
            .onDisappear {
                timer?.invalidate()
                timer = nil
            }
        }
    }

    return PreviewWrapper()
}
