import SwiftUI
import WidgetKit

struct ProgressProvider: TimelineProvider {
    func placeholder(in context: Context) -> ProgressEntry {
        ProgressEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ProgressEntry) -> ()) {
        completion(ProgressEntry(date: Date()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ProgressEntry>) -> Void) {
        let date = Calendar.current.date(byAdding: .minute, value: 25, to: Date())!
        let entries: [ProgressEntry] = [ProgressEntry(date: Date())]
        let timeline = Timeline(entries: entries, policy: .after(date))
        completion(timeline)
    }
}

struct ProgressEntry: TimelineEntry {
    var date: Date
    
}

struct ProgressWidgetEntryView: View {
    var entry: ProgressEntry
    
    // Get the widget's family.
    @Environment(\.widgetFamily) private var family
    @Environment(\.widgetRenderingMode) var renderingMode
    
    var body: some View {
        switch family {
        case .accessoryCorner:
            switch renderingMode {
            case .vibrant:
                Image("logo")
                    .widgetLabel {
                        ProgressView(value: 0.5, total: 1)
                            .tint(.blue)
                    }
            default:
                Image("add_white")
                    .widgetLabel {
                        ProgressView(value: 0.5, total: 1)
                    }
                    .widgetAccentable()
            }
        default:
            Gauge(value: 0.3) {
                Text("1/3")
                    .font(.system(size: 16, weight: .medium))
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(.blue)
        }
        
    }
}

struct ProgressWidget: Widget {
    let kind: ComplicationType = .progress
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind.rawValue,
                            provider: ProgressProvider())
        { entry in
            ProgressWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Task progress")
        .supportedFamilies([.accessoryCircular, .accessoryCorner])
    }
}


struct ProgressWidget_Previews: PreviewProvider {
    static var previews: some View {
        if #available(watchOSApplicationExtension 10.0, *) {
            ProgressWidgetEntryView(entry: ProgressEntry(date: .now))
                .previewContext(WidgetPreviewContext(family: .accessoryCorner))
                .containerBackground(.clear, for: .widget)
        } else {
            ProgressWidgetEntryView(entry: ProgressEntry(date: .now))
                .previewContext(WidgetPreviewContext(family: .accessoryCorner))
        }
        
    }
}
