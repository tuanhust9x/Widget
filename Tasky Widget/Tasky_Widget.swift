import WidgetKit
import SwiftUI

@main
struct Tasky_Widget: WidgetBundle {
    var body: some Widget {
        CreateTaskWidget()
        ProgressWidget()
        UpcomingWidget()
    }
}
