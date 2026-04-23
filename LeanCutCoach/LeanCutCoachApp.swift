import SwiftUI

@main
struct LeanCutCoachApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: PlanStore())
        }
    }
}
