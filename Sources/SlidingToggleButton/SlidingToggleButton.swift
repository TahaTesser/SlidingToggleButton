import SwiftUI

// MARK: - View Extension for Resizable Images

private extension View {
    @ViewBuilder
    func resizableIfImage() -> some View {
        if let image = self as? Image {
            image.resizable()
        } else {
            self
        }
    }
}

// MARK: - SlidingToggleButton

public struct SlidingToggleButton<StartIcon: View, EndIcon: View>: View {
    @Binding private var value: Bool
    @State private var buttonAlignment: Alignment
    @State private var animateStartIcon: Bool = false
    @State private var animateEndIcon: Bool = false

    public let size: CGFloat
    public let padding: CGFloat
    public let backgroundColor: Color
    public let buttonBackgroundColor: Color
    public let vertical: Bool
    private let startIcon: StartIcon
    private let endIcon: EndIcon

    /// Creates a sliding toggle button with two icon views.
    ///
    /// The icons are provided in a trailing closure and assigned based on order:
    /// - First view: start icon (true state)
    /// - Second view: end icon (false state)
    ///
    /// `Image` views are automatically made resizable and scaled to fit.
    /// Custom views are used as-is.
    ///
    /// Example usage:
    /// ```swift
    /// SlidingToggleButton(value: $isDarkMode) {
    ///     Image(systemName: "sun.max.fill")
    ///     Image(systemName: "moon.fill")
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - value: A binding to the toggle's state.
    ///   - size: The size of the icon area. Defaults to 24.
    ///   - padding: The padding around each icon. Defaults to 8.
    ///   - backgroundColor: The background color of the capsule.
    ///   - buttonBackgroundColor: The background color of the sliding button.
    ///   - vertical: Whether the toggle is vertical. Defaults to false.
    ///   - icons: A view builder containing exactly two views (start and end icons).
    public init(
        value: Binding<Bool>,
        size: CGFloat? = nil,
        padding: CGFloat? = nil,
        backgroundColor: Color? = nil,
        buttonBackgroundColor: Color? = nil,
        vertical: Bool? = nil,
        @ViewBuilder icons: () -> TupleView<(StartIcon, EndIcon)>
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

        let iconViews = icons().value
        self.startIcon = iconViews.0
        self.endIcon = iconViews.1
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
        startIcon
            .resizableIfImage()
            .scaledToFit()
            .frame(width: size, height: size)
            .padding(padding)
            .foregroundStyle(.white)
            .containerShape(.rect)
            .phaseAnimator([false, true], trigger: animateStartIcon) { content, _ in
                content
                    .symbolEffect(.bounce.byLayer, value: animateStartIcon)
            }
            .onTapGesture {
                handleStartIconTap()
            }
    }

    private var endIconView: some View {
        endIcon
            .resizableIfImage()
            .scaledToFit()
            .frame(width: size, height: size)
            .padding(padding)
            .foregroundStyle(.white)
            .containerShape(.rect)
            .phaseAnimator([false, true], trigger: animateEndIcon) { content, _ in
                content
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
                SlidingToggleButton(value: $isDarkMode) {
                    Image(systemName: "sun.max.fill")
                    Image(systemName: "moon.fill")
                }
                SlidingToggleButton(value: $isDarkMode, vertical: true) {
                    Image(systemName: "sun.max.fill")
                    Image(systemName: "moon.fill")
                }
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
