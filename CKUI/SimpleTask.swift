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

struct SimpleTaskWrapper<Content: View>: View {
    typealias ContentFunc = (OCKAnyEvent?, @escaping () -> Void) -> Content
    let content: ContentFunc
    @ObservedObject var controller: OCKSimpleTaskController
    
    var event: OCKAnyEvent? {
        controller.objectWillChange.value?.firstEvent
    }
    
    init(taskID: String,
         eventQuery: OCKEventQuery = OCKEventQuery(for: Date()),
         manager: OCKSynchronizedStoreManager,
         content: @escaping ContentFunc) {
        self.content = content
        self.controller = OCKSimpleTaskController(storeManager: manager)
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
        content(event, markComplete)
    }
}

