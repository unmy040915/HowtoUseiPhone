import Foundation
import SwiftData

@Model
final class Todo {
    var content: String
    var isDone: Bool

    init(content: String) {
        self.content = content
        isDone = false
    }
}
