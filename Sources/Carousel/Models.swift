import SwiftUI

@available(iOS 14.0, *)
public class AnimationModel: ObservableObject {
    @Published var firstAnimation = false
    @Published var profileArrayShown = false
    @Published var selected = false
    @Published var backgroundFade = false
    @Published var profileName = false
    @Published var titleFade = false
    
    @Published var gradientArray: [Color] = [Color.purple, Color(UIColor.purple)]
}

// Class holding the cards id and content
@available(iOS 14.0, *)
public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: CGFloat = 0.0
    @Published var cards: [NodeArrayData] = [
        NodeArrayData(id: 0, profileName: "Title 1"),
        NodeArrayData(id: 1, profileName: "Title 2"),
        NodeArrayData(id: 2, profileName: "Title 3"),
        NodeArrayData(id: 3, profileName: "Title 4"),
        NodeArrayData(id: 4, profileName: "Title 5"),
        NodeArrayData(id: 5, profileName: "Title 6"),
        NodeArrayData(id: 6, profileName: "Title 7"),
        NodeArrayData(id: 7, profileName: "Title 8"),
        NodeArrayData(id: 8, profileName: "Title 9")
    ]
}
