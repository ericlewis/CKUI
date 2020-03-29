import SwiftUI
import CareKit

struct ContentView: View {
    var body: some View {
        SimpleTask(taskID: "doxylaminee") { event, markComplete in
            Text(event?.task.title ?? "no task")
            Button(event?.outcome == nil ? "Mark as Completed" : "Completed",
                   action: markComplete)
        }
        .environment(\.manager,
                     OCKSynchronizedStoreManager(wrapping: OCKStore(name: "v1")))
    }
}
