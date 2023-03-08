
import SwiftUI

@available(iOS 14.0, *)
public struct CircleView: View {
    @ObservedObject var model: AnimationModel
    @Namespace var nspace
    @State var data: [UIStateModel.Gig]
    public init(model: AnimationModel, data: [UIStateModel.Gig]) {
        self.model = model
        self.data = data
    }
    
    public var body: some View {
        ZStack {
            if !model.selected {
                ZStack(alignment: .topTrailing) {
                    IconView(model: model, shown: model.selected)
                        .scaleEffect(model.firstAnimation ? 2.8 : 0.6)
                        .matchedGeometryEffect(id: "profile", in: nspace, properties: .position)
                        .padding(.trailing)
                        .onTapGesture{
                            withAnimation(.easeIn(duration: 0.39)) {
                                model.backgroundFade = true
                            }
                            withAnimation(.easeIn(duration: 0.4 )) {
                                model.selected.toggle()
                            }
                            withAnimation(.easeIn(duration: 0.45)) {
                                model.firstAnimation.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                                model.profileArrayShown = true
                            }
                        }
                    FillScreen()
                }
                .padding(.horizontal)
            } else {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 25)
                        .matchedGeometryEffect(id: "profile", in: nspace)
                        .matchedGeometryEffect(id: "animation", in: nspace)
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width - (32*2) - (16*2), height: 279)
                    
                    FillScreen()
                }
            }
        }
        .carouselMod(data: data)

    }
}

@available(iOS 14.0, *)
public struct IconView: View {
    let model: AnimationModel
    var shown = false
    @Namespace var nspace
    public var body: some View{
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: shown ? 0 : 150)
                    .fill(shown ?  RadialGradient(colors: [.black, .black], center: .topTrailing, startRadius: 45, endRadius: 110):
                            RadialGradient(colors: model.gradientArray, center: .topTrailing, startRadius: 45, endRadius: 110) )
                    .matchedGeometryEffect(id: "profile", in: nspace)
                    .frame(width: 77, height: 77)
            }
            .frame(width: 35, height: 35)
            .shadow(radius: 3)
        }
    }
}
