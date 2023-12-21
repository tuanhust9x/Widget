import SwiftUI
import WidgetKit
import Intents

struct NewTaskProvider: TimelineProvider {
    func placeholder(in context: Context) -> NewTaskEntry {
        NewTaskEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (NewTaskEntry) -> ()) {
        completion(NewTaskEntry(date: Date()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<NewTaskEntry>) -> Void) {
        
    }
}

struct NewTaskEntry: TimelineEntry {
    var date: Date
}

struct NewTaskWidgetEntryView: View {
    var entry: NewTaskEntry
    
    // Get the widget's family.
    @Environment(\.widgetFamily) private var family
    @Environment(\.widgetRenderingMode) var renderingMode
    
    var body: some View {
        switch renderingMode {
        case .accented:
            switch family {
            case .accessoryCorner:
//                GeometryReader { geo in
//                    Image("add_white")
//                        .resizable()
//                        .frame(width: geo.size.width, height:  geo.size.height)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                }
//                .widgetAccentable()
                Image("add_white")
                    .widgetLabel {
                        ProgressView(value: 0.5, total: 1)
                    }
                    .widgetAccentable()
            default:
                GeometryReader { geo in
                    Image("add_white")
                        .resizable()
                        .frame(width: geo.size.width, height:  geo.size.width * 0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .widgetAccentable()
                .background {
                    Rectangle()
                        .foregroundColor(.white.opacity(0.15))
                }
            }
        case .fullColor:
            switch family {
            case .accessoryCorner:
                Image("add_white")
                    .widgetLabel {
                        ProgressView(value: 0.5, total: 1)
                    }
                    .widgetAccentable()
            default:
                GeometryReader { geo in
                    Image("add_white")
                        .resizable()
                        .frame(width: geo.size.width * 0.5, height:  geo.size.width * 0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background {
                    Rectangle()
                        .foregroundColor(.white.opacity(0.15))
                }
            }
        default:
            GeometryReader { geo in
                VStack {
                    Image("add_blue")
                        .resizable()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct CreateTaskWidget: Widget {
    let kind: ComplicationType = .createTask
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind.rawValue,
                            provider: NewTaskProvider())
        { entry in
            NewTaskWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Create task")
        .supportedFamilies([.accessoryCircular, .accessoryCorner])
    }
}

struct CreateTaskWidget_Previews: PreviewProvider {
    
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    
    static var previews: some View {
        if #available(watchOSApplicationExtension 10.0, *) {
            NewTaskWidgetEntryView(entry: NewTaskEntry(date: .now))
                .previewContext(WidgetPreviewContext(family: .accessoryCorner))
                .containerBackground(.clear, for: .widget)
        } else {
            NewTaskWidgetEntryView(entry: NewTaskEntry(date: .now))
                .previewContext(WidgetPreviewContext(family: .accessoryCorner))
        }
    }
}
