import SwiftUI
import CareKitStore

struct TaskLogButton<Label: View>: View {
    let taskID: String
    let label: (Bool) -> Label
    
    func makeContent(_ event: OCKAnyEvent?,
                     complete: Bool,
                     markComplete: @escaping () -> Void) -> some View {
        Button(action: markComplete) {
            label(complete)
        }
    }
    
    var body: some View {
        SimpleTask(taskID: taskID, content: makeContent)
    }
}
