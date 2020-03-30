import SwiftUI
import CareKit

struct ButtonTaskLog<Content: View>: View {
    let taskID: String
    let eventQuery: OCKEventQuery
    let content: ButtonLogWrapper<Content>.ContentFunc
    
    init(taskID: String,
         eventQuery: OCKEventQuery = OCKEventQuery(for: Date()),
         @ViewBuilder content: @escaping ButtonLogWrapper<Content>.ContentFunc) {
        self.taskID = taskID
        self.eventQuery = eventQuery
        self.content = content
    }
    
    var body: some View {
        ManagerWrapper {
            ButtonLogWrapper(taskID: self.taskID,
                             eventQuery: self.eventQuery,
                             manager: $0,
                             content: self.content)
        }
    }
}

struct ButtonLogWrapper<Content: View>: View {
    typealias ContentFunc = (OCKTaskEvents?, @escaping () -> Void) -> Content
    let content: ContentFunc
    @ObservedObject var controller: OCKButtonLogTaskController
    
    var event: OCKTaskEvents? {
        controller.objectWillChange.value
    }
    
    init(taskID: String,
         eventQuery: OCKEventQuery = OCKEventQuery(for: Date()),
         manager: OCKSynchronizedStoreManager,
         content: @escaping ContentFunc) {
        self.content = content
        self.controller = OCKButtonLogTaskController(storeManager: manager)
        controller.fetchAndObserveEvents(forTaskID: taskID,
                                         eventQuery: eventQuery)
    }
    
    var log: () -> Void {
        {
            return
        }
    }
    
    var body: some View {
        content(event, log)
    }
}

