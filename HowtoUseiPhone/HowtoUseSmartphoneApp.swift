import SwiftUI
import SwiftData

@main
struct HowtoUseSmartphoneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TaskData.self)
    }
}
