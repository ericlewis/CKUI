import SwiftUI
import CareKitStore

struct ChecklistTaskView: View {
    var taskID: String
    let eventQuery: OCKEventQuery = OCKEventQuery(for: Date())
    let type: OCKOutcomeValueUnderlyingType? = nil
    
    var body: some View {
        ChecklistTask(taskID: taskID, eventQuery: eventQuery) { events, markComplete in
            ForEach(events ?? [], id: \.task.id) {
                Text($0.task.id)
            }
        }
    }
}
