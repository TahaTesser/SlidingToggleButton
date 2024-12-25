
import SwiftUI

class SlidingToggleButtonDefaults {
  static  let defaultSize: CGFloat = 32
    static let padding: CGFloat = 8
    static  let backgroundColor: Color = .secondary.opacity(0.3)
    static  let buttonBackgroundColor: Color = .primary.opacity(0.44)

}

public struct SlidingToggleButton: View {
    
    @Binding var isToggled: Bool
    
    @State private var buttonShapePosition: CGFloat = 0
    @State private var animateStartIcon: Bool = false
    @State private var animateEndIcon: Bool = false

    let size: CGFloat
    let padding: CGFloat
    let backgroundColor: Color
    let buttonBackgroundColor: Color

    public init(
        isToggled: Binding<Bool>,
        onChange: ((Bool) -> Void)? = nil,
        size: CGFloat? = nil,
        padding: CGFloat? = nil,
        backgroundColor: Color? = nil,
        buttonBackgroundColor: Color? = nil
    ) {
        self._isToggled = isToggled
        self.size = size ?? SlidingToggleButtonDefaults.defaultSize
        self.padding = padding ?? SlidingToggleButtonDefaults.padding
        self.backgroundColor = backgroundColor ?? SlidingToggleButtonDefaults.backgroundColor
        self.buttonBackgroundColor = buttonBackgroundColor ?? SlidingToggleButtonDefaults.buttonBackgroundColor
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            Circle()
                .fill(buttonBackgroundColor)
                .frame(
                    width: size + (padding * 2),
                    height: size + (padding * 2))
                .offset(x: buttonShapePosition)
                .animation(.spring(response: 0.3), value: isToggled)
            
            HStack(spacing: 0) {
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .frame(width: size, height: size)
                    .padding(padding)
                    .foregroundStyle(.white)
                    .containerShape(.rect)
                    .phaseAnimator([false , true], trigger: animateStartIcon) { sparkleSymbol, animate in
                                sparkleSymbol
                            .symbolEffect(.bounce.byLayer, value: animateStartIcon)
                            }
                        
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3)) {
                            isToggled = true
                            animateStartIcon.toggle()
                            buttonShapePosition = 0
                        }
                    }
                
                Image(systemName: "moon.fill")
                    .resizable()
                    .frame(width: size, height: size)
                    .padding(padding)
                    .foregroundStyle(.white)
                    .containerShape(.rect)
                    .phaseAnimator([false , true], trigger: animateEndIcon) { sparkleSymbol, animate in
                                sparkleSymbol
                            .symbolEffect(.bounce.byLayer, value: animateEndIcon)
                            }

                    .onTapGesture {
                        withAnimation(.spring(response: 0.3)) {
                            isToggled = false
                            buttonShapePosition = size + (padding * 2)
                            animateEndIcon.toggle()
                        }
                    }
            }
     

        }
        .background(
            Capsule()
                .fill(backgroundColor)
        )

    }
}

#Preview(traits: .sizeThatFitsLayout) {
    struct PreviewWrapper: View {
        @State private var isDarkMode = false
        
        var body: some View {
            SlidingToggleButton(
                isToggled: $isDarkMode
            )
        }
    }
    
    return PreviewWrapper()
}
