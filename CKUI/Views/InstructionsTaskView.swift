import SwiftUI
import CareKitStore

struct InstructionsTaskView: View {
    var taskID: String
    let eventQuery: OCKEventQuery = OCKEventQuery(for: Date())
    
    var body: some View {
        InstructionsTask(taskID: taskID, eventQuery: eventQuery) { event, isComplete, markComplete in
            VStack(alignment: .leading) {
                event?.task.title.map { Text($0).font(.headline) }
                event.map { Text(OCKScheduleUtility.timeLabel(for: $0)) }
                event?.task.instructions.map { instructions in
                    Group {
                        Divider()
                        Text(instructions)
                            .font(.headline)
                    }
                }
                Button(isComplete ? "Complete" : "Mark Complete", action: markComplete)
                    .buttonStyle(RoundedButtonStyle())
                    .padding()
            }
            .foregroundColor(.primary)
        }
    }
}
