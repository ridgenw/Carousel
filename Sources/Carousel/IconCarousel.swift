import SwiftUI

@available(iOS 14.0, *)
public struct IconCarousel: View {
    @StateObject public var animate = AnimationModel()
    @StateObject public var UIState = UIStateModel()
    @State private var forEachOpactiy = false
    @State private var coverSquareAnimation = false
    @State private var isActivated = false
    @Namespace var nspace
    @State var items: [NodeModel]
    
    public var body: some View {
                .opacity(animate.selected ? 0 : 1)
            ZStack {
                if !animate.profileArrayShown {
                    ZStack {
                        CircleView(model: animate)
                            .onTapGesture(perform: {
                                isActivated.toggle()
                            })
                    }
                } else {
                    ZStack{
                        CarouselView(items: items)
                            .opacity(forEachOpactiy ? 1 : 0)
                            .environmentObject(UIState)
                            .environmentObject(animate)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.black)
                                    .frame(width: UIScreen.main.bounds.width - (32*2) - (16*2), height: 279)
                                    .opacity(coverSquareAnimation ? 0 : 1)
                            )
                            .onAppear() {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation(.easeIn(duration: 0.3)) {
                                        forEachOpactiy = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.31) {
                                        coverSquareAnimation = true
                                        withAnimation(.easeIn(duration: 0.4)) {
                                            animate.titleFade = true
                                        }
                                    }
                                }
                            }
                        
                        FillScreen()
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .ignoresSafeArea()
                    .foregroundColor(.clear)
                    .backgroundGrad()
                    .opacity(animate.backgroundFade ? 1 : 0) )
    }
}
