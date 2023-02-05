import SwiftUI

@available(iOS 14.0, *)
public func calculatePercent(lowerNumber: CGFloat, higherNumber: CGFloat) -> CGFloat {
    @State var lowerNum: CGFloat = lowerNumber
    @State var higherNum: CGFloat = higherNumber
    @State var percent: CGFloat
    
     percent = ((lowerNum / higherNum) * 25)
    
    return percent
}

@available(iOS 14.0, *)
public extension View {
    func horizonatalPadding() -> CGFloat {
        calculatePercent(
            lowerNumber: UIScreen.main.bounds.width - 20,
            higherNumber: UIScreen.main.bounds.width)
    }
}

@available(iOS 14.0, *)
public struct FillScreen: View {
    public var body: some View{
        VStack {
            HStack {
                Spacer()
            }
            Spacer()
        }
    }
}

@available(iOS 14.0, *)
public struct GradientBackground: ViewModifier {
    let model = AnimationModel()
    var selection = false
    public func body(content: Content) -> some View {
        return content
            .background( RadialGradient(colors: model.gradientArray, center: .center, startRadius: 100, endRadius: 600)).opacity(0.90)
    }
}

@available(iOS 14.0, *)
public extension View {
    func backgroundGrad() -> some View {
        modifier(GradientBackground())
    }
}

@available(iOS 14.0, *)
public extension View {
    func carousel(data: [UIStateModel.Gig]) -> some View {
        modifier(IconCarousel(data: data))
    }
}
