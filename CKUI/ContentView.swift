import SwiftUI
import CareKit

struct ContentView: View {
    var body: some View {
        SimpleTask(taskID: "doxylaminee") { event, markComplete in
            Text(event?.task.title ?? "no task")
            Button(event?.outcome == nil ? "Mark as Completed" : "Completed",
                   action: markComplete)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTaskWrapper(taskID: "doxylaminee", manager: manager)  { event, _ in
            Text("neat")
        }
    }
}
