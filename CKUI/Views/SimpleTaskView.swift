import SwiftUI
import CareKitStore

struct SimpleTaskView: View {
    var taskID: String
    let eventQuery: OCKEventQuery = OCKEventQuery(for: Date())
    
    var body: some View {
        SimpleTask(taskID: taskID, eventQuery: eventQuery) { event, isComplete, markComplete in
            Button(action: markComplete) {
                HStack {
                    VStack(alignment: .leading) {
                        event?.task.title.map { Text($0).font(.headline) }
                        event.map { Text(OCKScheduleUtility.timeLabel(for: $0)) }
                    }
                    .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isComplete ? "checkmark.circle.fill" : "circle")
                        .font(.title)
                }
            }
        }
    }
}
