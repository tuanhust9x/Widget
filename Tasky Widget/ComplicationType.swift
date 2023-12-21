import Foundation

enum ComplicationType: String {
    case createTask = "Create task"
    case progress = "Progress"
    case upcomingTask = "Upcoming task"
    
    var identifier: String {
        return self.rawValue
    }
    
    var name: String {
        return self.rawValue
    }
    
    var status: String {
        return "No task right now!"
    }
    
    var message: String {
        return "Enjoy your day"
    }
}
