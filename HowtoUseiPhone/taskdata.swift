import Foundation
import SwiftData

@Model
class TaskData {
    var title: String
    var isDone: Bool
    var Color: String

    init(title: String, isDone: Bool = false, Color: String) {
        self.title = title
        self.isDone = isDone
        self.Color = Color
    }
}
