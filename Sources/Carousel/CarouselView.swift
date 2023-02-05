import SwiftUI

@available(iOS 14.0, *)
public struct CarouselView: View {
    @EnvironmentObject var UIState: UIStateModel
    @EnvironmentObject var model: AnimationModel
    @State private var isActive = false
    @Namespace var nspace
    @State var data = [UIStateModel.Gig]()
    
    
   public var body: some View {
        let spacing: CGFloat = 16
        let widthOfHiddenCards: CGFloat = 32
        let cardHeight: CGFloat = 279
       
        return NavigationView {
            Background {
                Carousel(numberOfItems: CGFloat(data.count), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards)
                {
                    ForEach(data, id: \.self.id) { item in
                        ZStack{
                            Item( _id: Int(item.id),
                                  spacing: spacing,
                                  widthOfHiddenCards: widthOfHiddenCards,
                                  cardHeight: cardHeight)
                            {
                                Text("\(item.string)")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .opacity(model.titleFade ? 1 : 0)
                            }
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .cornerRadius(25)
                            .transition(AnyTransition.slide)
                        }
                    }
                }
            }
            
        }
    }
}



@available(iOS 14.0, *)
public struct Carousel <Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat //= 8
    let spacing: CGFloat //= 16
    let widthOfHiddenCards: CGFloat //= 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    @Namespace var namespace
    @ObservedObject var UIState = UIStateModel()
    
    public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
            self.items = items()
            self.numberOfItems = numberOfItems
            self.spacing = spacing
            self.widthOfHiddenCards = widthOfHiddenCards
            self.totalSpacing = (numberOfItems - 1) * spacing
            self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //318
        }
    
    public var body: some View {
        
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)
        let firstCard = UIState.cards.first!
        let lastCard = UIState.cards.last!
        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + Float(UIState.screenDrag)
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .environmentObject(UIState)
        .gesture(DragGesture()
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                withAnimation(.spring()) {
                    UIState.screenDrag = currentState.translation.width
                }
            }
            .onEnded { value in
                withAnimation(.spring()) {
                    UIState.screenDrag = 0
                    
                    if Int(UIState.activeCard) == firstCard.id && value.translation.width > 50 {
                        UIState.activeCard = self.UIState.activeCard
                    } else if Int(UIState.activeCard) == lastCard.id && value.translation.width < -50 {
                        UIState.activeCard = self.UIState.activeCard
                    } else {
                        if (value.translation.width < -50) {
                            UIState.activeCard = self.UIState.activeCard + 1
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }
                        if (value.translation.width > 50) {
                            UIState.activeCard = self.UIState.activeCard - 1
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }
                    }
                }
            })
    }
}

@available(iOS 14.0, *)
public struct Background < Content : View > : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    @ObservedObject var model = AnimationModel()
    
    public init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    public var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(
                RadialGradient(colors: model.gradientArray, center: .center, startRadius: 100, endRadius: 600).edgesIgnoringSafeArea(.all)
            )
    }
}

@available(iOS 14.0, *)
public struct Item<Content: View>: View {
    @EnvironmentObject var UIState: UIStateModel
    @Namespace var namespace
    
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    
    var _id: Int
    var content: Content
    
    public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content) {
            self.content = content()
            self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2)
            self.cardHeight = cardHeight
            self._id = _id
        }
    
    public var body: some View {
        ZStack {
            content
                .frame(width: cardWidth, height: cardHeight, alignment: .center)
        }
    }
}

