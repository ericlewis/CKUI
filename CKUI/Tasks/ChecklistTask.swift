import SwiftUI
import CareKit

struct ChecklistTask<Content: View>: View {
    let taskID: String
    let eventQuery: OCKEventQuery
    let content: ChecklistTaskWrapper<Content>.ContentFunc
    
    init(taskID: String,
         eventQuery: OCKEventQuery = OCKEventQuery(for: Date()),
         @ViewBuilder content: @escaping ChecklistTaskWrapper<Content>.ContentFunc) {
        self.taskID = taskID
        self.eventQuery = eventQuery
        self.content = content
    }
    
    var body: some View {
        ManagerWrapper {
            ChecklistTaskWrapper(taskID: self.taskID,
                                 eventQuery: self.eventQuery,
                                 manager: $0,
                                 content: self.content)
        }
    }
}

struct ChecklistTaskWrapper<Content: View>: View {
    typealias ContentFunc = ([OCKAnyEvent]?, @escaping (OCKAnyEvent) -> Void) -> Content
    let content: ContentFunc
    @ObservedObject var controller: OCKChecklistTaskController
    
    var events: [OCKAnyEvent]? {
        controller.objectWillChange.value?.firstEvents
    }
    
    init(taskID: String,
         eventQuery: OCKEventQuery = OCKEventQuery(for: Date()),
         manager: OCKSynchronizedStoreManager,
         content: @escaping ContentFunc) {
        self.content = content
        self.controller = OCKChecklistTaskController(storeManager: manager)
        controller.fetchAndObserveEvents(forTaskID: taskID,
                                         eventQuery: eventQuery)
    }
    
    var markComplete: (OCKAnyEvent) -> Void {
        { type in
            
        }
    }
    
    var body: some View {
        content(events, markComplete)
    }
}
