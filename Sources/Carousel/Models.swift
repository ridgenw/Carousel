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

@available(iOS 14.0, *)
public struct NodeModel: Codable, Hashable, Identifiable {
   public let id: Int
    let profileName: String
}

// Class holding the cards id and content
@available(iOS 14.0, *)
public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: CGFloat = 0.0
    @Published var cards: [NodeModel] = [
        NodeModel(id: 0, profileName: "Title 1"),
        NodeModel(id: 1, profileName: "Title 2"),
        NodeModel(id: 2, profileName: "Title 3"),
        NodeModel(id: 3, profileName: "Title 4"),
        NodeModel(id: 4, profileName: "Title 5"),
        NodeModel(id: 5, profileName: "Title 6"),
        NodeModel(id: 6, profileName: "Title 7"),
        NodeModel(id: 7, profileName: "Title 8"),
        NodeModel(id: 8, profileName: "Title 9")
    ]
}
