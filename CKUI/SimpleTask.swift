import SwiftUI
import CareKit

struct SimpleTask<Content: View>: View {
    let taskID: String
    let eventQuery: OCKEventQuery
    let content: SimpleTaskWrapper<Content>.ContentFunc
    
    init(taskID: String,
         eventQuery: OCKEventQuery = OCKEventQuery(for: Date()),
         @ViewBuilder content: @escaping SimpleTaskWrapper<Content>.ContentFunc) {
        self.taskID = taskID
        self.eventQuery = eventQuery
        self.content = content
    }
    
    
    var body: some View {
        ManagerWrapper {
            SimpleTaskWrapper(taskID: self.taskID,
                              eventQuery: self.eventQuery,
                              manager: $0,
                              content: self.content)
        }
    }
}
