import SwiftUI
import CareKitStore

struct ButtonLogTaskView: View {
    var taskID: String
    let eventQuery: OCKEventQuery = OCKEventQuery(for: Date())
    let type: OCKOutcomeValueUnderlyingType? = nil

    var body: some View {
        ButtonLogTask(taskID: taskID, eventQuery: eventQuery) { event, values, log in
            Text(event?.task.title ?? "no task")
            Button("Log") {
                log(self.type)
            }
            ForEach(values?.compactMap { $0.booleanValue } ?? [], id: \.self) {
                Text(String($0))
            }
        }
    }
}
