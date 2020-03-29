//
//  ContentView.swift
//  CKUI
//
//  Created by Eric Lewis on 3/28/20.
//  Copyright © 2020 Eric Lewis. All rights reserved.
//

import SwiftUI
import CareKit

let thisMorning = Calendar.current.startOfDay(for: Date())
let store = OCKStore(name: "v1")
let sched = OCKSchedule(composing: [.init(start: thisMorning, end: nil, interval: DateComponents(day: 1))])
let manager = OCKSynchronizedStoreManager(wrapping: store)

struct ContentView: View {
    var body: some View {
        SimpleTaskWrapper(taskID: "doxylaminee")  { event, markComplete in
            Text(event?.task.title ?? "no task")
            Button(event?.outcome == nil ? "Mark as Completed" : "Completed",
                   action: markComplete)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTaskWrapper(taskID: "doxylaminee")  { event, _ in
            Text("neat")
        }
    }
}
