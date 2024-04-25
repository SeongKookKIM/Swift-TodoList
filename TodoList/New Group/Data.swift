import Foundation
import SwiftUI
import SwiftData

enum Priority: Comparable, Codable {
    case high
    case medium
    case low
    
    var description: String {
        switch self {
        case .high:
            return "중요"
        case .medium:
            return "중간"
        case .low:
            return "낮음"
        }
    }
    
    var color: Color {
        switch self {
        case .high:
            return .red
        case .medium:
            return .orange
        case .low:
            return .green
        }
    }
}

@Model
class Task: Identifiable {
    var id: UUID
    var completed: Bool
    var taskDescription: String
    var priority: Priority
    
    init(id: UUID = UUID(), completed: Bool, taskDescription: String, priority: Priority) {
        self.id = id
        self.completed = completed
        self.taskDescription = taskDescription
        self.priority = priority
    }
}


