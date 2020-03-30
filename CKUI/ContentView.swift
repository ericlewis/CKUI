import SwiftUI
import CareKit

struct ContentView: View {
    var body: some View {
        Form {
            Section(header: Text("Simple Task")) {
                SimpleTaskView(taskID: "doxylaminee")
            }
            Section(header: Text("Instructions Task")) {
                InstructionsTaskView(taskID: "doxylaminee")
            }
            Section(header: Text("Button Log Task")) {
                ButtonLogTaskView(taskID: "doxylaminee")
            }
            Section(header: Text("Checklist Task")) {
                ChecklistTaskView(taskID: "doxylaminee")
            }
        }
        .environment(\.manager, manager)
    }
}
