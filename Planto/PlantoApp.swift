
import SwiftUI
import Foundation

@main
struct PlantoApp: App {
    @StateObject private var store = PlantStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .preferredColorScheme(.dark)
                .task {
                    try? await NotificationManager.requestAuthorizationIfNeeded()
                }
        }
    }
}
