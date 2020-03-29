import SwiftUI
import CareKit

struct SimpleTaskWrapper<Content: View>: View {
    typealias ContentFunc = (OCKAnyEvent?, @escaping () -> Void) -> Content
    let content: ContentFunc
    @ObservedObject var controller = OCKSimpleTaskController(storeManager: manager)
    
    var event: OCKAnyEvent? {
        controller.objectWillChange.value?.firstEvent
    }
    
    init(taskID: String,
         eventQuery: OCKEventQuery = OCKEventQuery(for: Date()),
         @ViewBuilder content: @escaping ContentFunc) {
        self.content = content
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