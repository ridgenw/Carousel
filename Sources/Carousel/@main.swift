import SwiftUI

@available(iOS 14.0, *)
@main
struct ProfileAnimation_TestAppApp: App {
    @StateObject var logic = AnimationModel()
    var body: some Scene {
        WindowGroup {
            CarouselView()
                .environmentObject(UIStateModel())
                .environmentObject(AnimationModel())
        }
    }
}
