import SwiftUI
import WidgetKit
import Intents

struct UpcomingProvider: TimelineProvider {
    func placeholder(in context: Context) -> UpcomingEntry {
        UpcomingEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (UpcomingEntry) -> ()) {
        completion(UpcomingEntry(date: Date()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<UpcomingEntry>) -> Void) {
        
    }
}

struct UpcomingEntry: TimelineEntry {
    var date: Date
    
}

struct UpcomingWidgetEntryView: View {
    var entry: UpcomingEntry
    
    let complicationType: ComplicationType = .upcomingTask
    
    // Get the widget's family.
    @Environment(\.widgetFamily) private var family
    @Environment(\.widgetRenderingMode) var renderingMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(complicationType.status)
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .lineLimit(1)
                .foregroundColor(.primary)
            Text(complicationType.message)
                .font(.system(size: 16, design: .rounded))
                .lineLimit(1)
                .foregroundColor(.secondary)
        }
    }
}


struct UpcomingWidget: Widget {
    let kind: ComplicationType = .upcomingTask
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind.rawValue,
                            provider: UpcomingProvider())
        { entry in
            UpcomingWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Upcoming task")
        .supportedFamilies([.accessoryInline, .accessoryRectangular])
    }
}

struct UpcomingWidget_Previews: PreviewProvider {
    static var previews: some View {
        if #available(watchOSApplicationExtension 10.0, *) {
            UpcomingWidgetEntryView(entry: UpcomingEntry(date: .now))
                .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                .containerBackground(.clear, for: .widget)
        } else {
            UpcomingWidgetEntryView(entry: UpcomingEntry(date: .now))
                .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
        }
    }
}
