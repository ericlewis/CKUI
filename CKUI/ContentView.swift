import SwiftUI
import CareKit

struct Card<Content: View>: View {
    let content: () -> Content
    
    func makeBackground() -> some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(Color(.systemBackground))
    }
    
    var body: some View {
        content()
            .padding()
            .background(makeBackground())
            .shadow(radius: 10)
    }
}

struct ContentView: View {
    var body: some View {
        Form {
            Section(header: Text("Simple Task")) {
                Card {
                    SimpleTaskView(taskID: "doxylaminee")
                }
                .padding()
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
            Section(header: Text("Pieces")) {
                TaskLogButton(taskID: "doxylaminee") { isComplete in
                    Text(isComplete ? "COMPLETED!" : "MARK COMPLETE")
                }
            }
        }
        .environment(\.manager, manager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.manager, manager)
    }
}
