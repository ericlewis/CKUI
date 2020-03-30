import SwiftUI
import CareKit

struct InstructionsTask<Content: View>: View {
    let taskID: String
    let eventQuery: OCKEventQuery
    let content: InstructionsTaskWrapper<Content>.ContentFunc
    
    init(taskID: String,
         eventQuery: OCKEventQuery = OCKEventQuery(for: Date()),
         @ViewBuilder content: @escaping InstructionsTaskWrapper<Content>.ContentFunc) {
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

struct InstructionsTaskWrapper<Content: View>: View {
    typealias ContentFunc = (OCKAnyEvent?, Bool, @escaping () -> Void) -> Content
    let content: ContentFunc
    @ObservedObject var controller: OCKInstructionsTaskController
    
    var event: OCKAnyEvent? {
        controller.objectWillChange.value?.firstEvent
    }
    
    init(taskID: String,
         eventQuery: OCKEventQuery = OCKEventQuery(for: Date()),
         manager: OCKSynchronizedStoreManager,
         content: @escaping ContentFunc) {
        self.content = content
        self.controller = OCKInstructionsTaskController(storeManager: manager)
        controller.fetchAndObserveEvents(forTaskID: taskID,
                                         eventQuery: eventQuery)
    }
    
    var markComplete: () -> Void {
    {
        let isComplete = self.event?.outcome != nil
        self.controller.setEvent(atIndexPath: IndexPath(row: 0, section: 0),
                                 isComplete: !isComplete, completion: nil)
        }
    }
    
    var body: some View {
        content(event, event?.outcome != nil, markComplete)
    }
}

