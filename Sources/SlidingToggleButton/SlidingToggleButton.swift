import SwiftUI

// MARK: - SlidingToggleButton

/// A minimal SwiftUI toggle that slides a highlight across 2–3 icons.
///
/// The view renders the provided icons inside a capsule and animates an
/// indicator circle between positions when the selection changes. Use the
/// `selection` binding to read and update the selected index (0-based) and
/// configure layout with the public properties or the initializer defaults.
public struct SlidingToggleButton: View {
    @Binding private var selection: Int
    @State private var buttonAlignment: Alignment
    @State private var animationTriggers: [Bool]

    /// The width and height of each icon.
    public let size: CGFloat
    /// The padding around each icon inside the capsule.
    public let padding: CGFloat
    /// The capsule background color behind the indicator circle.
    public let backgroundColor: Color
    /// The indicator circle color that highlights the active icon.
    public let buttonBackgroundColor: Color
    /// Whether icons are stacked vertically instead of horizontally.
    public let vertical: Bool

    private let icons: [AnyView]
    private let iconCount: Int

    // MARK: - 2-Icon Initializer

    /// Creates a sliding toggle button with two icons.
    ///
    /// - Parameters:
    ///   - selection: The currently selected icon index. Updates on tap.
    ///   - size: Optional override for icon size. Defaults to 24.
    ///   - padding: Optional override for icon padding. Defaults to 8.
    ///   - backgroundColor: Optional override for the capsule background.
    ///   - buttonBackgroundColor: Optional override for the indicator circle.
    ///   - vertical: Render vertically when `true`, horizontally otherwise.
    ///   - icons: A builder that returns two icons, e.g. two SF Symbols.
    public init<Icon0: View, Icon1: View>(
        selection: Binding<Int>,
        size: CGFloat? = nil,
        padding: CGFloat? = nil,
        backgroundColor: Color? = nil,
        buttonBackgroundColor: Color? = nil,
        vertical: Bool? = nil,
        @ViewBuilder icons: () -> TupleView<(Icon0, Icon1)>
    ) {
        let iconViews = icons().value
        self.init(
            selection: selection,
            size: size,
            padding: padding,
            backgroundColor: backgroundColor,
            buttonBackgroundColor: buttonBackgroundColor,
            vertical: vertical,
            iconArray: [AnyView(iconViews.0), AnyView(iconViews.1)]
        )
    }

    // MARK: - 3-Icon Initializer

    /// Creates a sliding toggle button with three icons.
    ///
    /// - Parameters:
    ///   - selection: The currently selected icon index. Updates on tap.
    ///   - size: Optional override for icon size. Defaults to 24.
    ///   - padding: Optional override for icon padding. Defaults to 8.
    ///   - backgroundColor: Optional override for the capsule background.
    ///   - buttonBackgroundColor: Optional override for the indicator circle.
    ///   - vertical: Render vertically when `true`, horizontally otherwise.
    ///   - icons: A builder that returns three icons, e.g. three SF Symbols.
    public init<Icon0: View, Icon1: View, Icon2: View>(
        selection: Binding<Int>,
        size: CGFloat? = nil,
        padding: CGFloat? = nil,
        backgroundColor: Color? = nil,
        buttonBackgroundColor: Color? = nil,
        vertical: Bool? = nil,
        // swiftlint:disable:next large_tuple
        @ViewBuilder icons: () -> TupleView<(Icon0, Icon1, Icon2)>
    ) {
        let iconViews = icons().value
        self.init(
            selection: selection,
            size: size,
            padding: padding,
            backgroundColor: backgroundColor,
            buttonBackgroundColor: buttonBackgroundColor,
            vertical: vertical,
            iconArray: [AnyView(iconViews.0), AnyView(iconViews.1), AnyView(iconViews.2)]
        )
    }

    // MARK: - Private Initializer

    private init(
        selection: Binding<Int>,
        size: CGFloat?,
        padding: CGFloat?,
        backgroundColor: Color?,
        buttonBackgroundColor: Color?,
        vertical: Bool?,
        iconArray: [AnyView]
    ) {
        let effectiveVertical = vertical ?? SlidingToggleButtonDefaults.vertical
        let iconCount = iconArray.count

        _selection = selection
        _buttonAlignment = State(initialValue: Self.computeAlignment(
            for: selection.wrappedValue,
            iconCount: iconCount,
            vertical: effectiveVertical
        ))
        _animationTriggers = State(initialValue: Array(repeating: false, count: iconCount))

        self.size = size ?? SlidingToggleButtonDefaults.defaultSize
        self.padding = padding ?? SlidingToggleButtonDefaults.padding
        self.backgroundColor = backgroundColor ?? SlidingToggleButtonDefaults.backgroundColor
        self.buttonBackgroundColor = buttonBackgroundColor ?? SlidingToggleButtonDefaults.buttonBackgroundColor
        self.vertical = effectiveVertical
        self.icons = iconArray
        self.iconCount = iconCount
    }

    // MARK: - Body

    public var body: some View {
        ZStack(alignment: buttonAlignment) {
            Circle()
                .fill(buttonBackgroundColor)
                .frame(width: size + (padding * 2), height: size + (padding * 2))

            flexibleStack(vertical: vertical, spacing: 0) {
                ForEach(0..<iconCount, id: \.self) { index in
                    iconView(at: index)
                }
            }
        }
        .background(Capsule().fill(backgroundColor))
        .onChange(of: selection) { _, newValue in
            withAnimation(.spring(response: 0.3)) {
                buttonAlignment = Self.computeAlignment(
                    for: newValue,
                    iconCount: iconCount,
                    vertical: vertical
                )
                if newValue < animationTriggers.count {
                    animationTriggers[newValue].toggle()
                }
            }
        }
    }

    // MARK: - Private Views

    private func iconView(at index: Int) -> some View {
        icons[index]
            .resizableIfImage()
            .scaledToFit()
            .frame(width: size, height: size)
            .padding(padding)
            .foregroundStyle(.white)
            .containerShape(.rect)
            .phaseAnimator([false, true], trigger: animationTriggers[index]) { content, _ in
                content.symbolEffect(.bounce.byLayer, value: animationTriggers[index])
            }
            .onTapGesture {
                handleTap(at: index)
            }
    }

    // MARK: - Private Methods

    private static func computeAlignment(for index: Int, iconCount: Int, vertical: Bool) -> Alignment {
        switch iconCount {
        case 2:
            return index == 0
                ? (vertical ? .top : .leading)
                : (vertical ? .bottom : .trailing)
        case 3:
            switch index {
            case 0: return vertical ? .top : .leading
            case 1: return .center
            default: return vertical ? .bottom : .trailing
            }
        default:
            return .center
        }
    }

    private func handleTap(at index: Int) {
        withAnimation(.spring(response: 0.3)) {
            selection = index
            buttonAlignment = Self.computeAlignment(for: index, iconCount: iconCount, vertical: vertical)
            animationTriggers[index].toggle()
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

// MARK: - View Extension

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

// MARK: - Preview

#Preview {
    struct PreviewWrapper: View {
        @State private var twoIcon = 0
        @State private var threeIcon = 0

        var body: some View {
            VStack(spacing: 30) {
                VStack(spacing: 8) {
                    Text("2-Icon: \(twoIcon)")
                    HStack(spacing: 20) {
                        SlidingToggleButton(selection: $twoIcon) {
                            Image(systemName: "sun.max.fill")
                            Image(systemName: "moon.fill")
                        }
                        SlidingToggleButton(selection: $twoIcon, vertical: true) {
                            Image(systemName: "sun.max.fill")
                            Image(systemName: "moon.fill")
                        }
                    }
                }

                VStack(spacing: 8) {
                    Text("3-Icon: \(threeIcon)")
                    HStack(spacing: 20) {
                        SlidingToggleButton(selection: $threeIcon) {
                            Image(systemName: "sun.max.fill")
                            Image(systemName: "circle.lefthalf.filled")
                            Image(systemName: "moon.fill")
                        }
                        SlidingToggleButton(selection: $threeIcon, vertical: true) {
                            Image(systemName: "sun.max.fill")
                            Image(systemName: "circle.lefthalf.filled")
                            Image(systemName: "moon.fill")
                        }
                    }
                }
            }
            .padding()
        }
    }
    return PreviewWrapper()
}
