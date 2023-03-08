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
    
    public init() { }
}

@available(iOS 14.0, *)
public struct NodeModel: Codable, Hashable, Identifiable {
   public let id: Int
    let profileName: String
}

// Class holding the cards id and content
@available(iOS 14.0, *)
public class UIStateModel: ObservableObject {
   public init() { }
    @Published var activeCard: Int = 0
    @Published var screenDrag: CGFloat = 0.0
    @Published var cards: [NodeModel] = []
}

