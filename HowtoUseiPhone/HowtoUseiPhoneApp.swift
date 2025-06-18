import SwiftUI
import SwiftData

@main
struct HowtoUseiPhoneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TaskData.self)
    }
}
