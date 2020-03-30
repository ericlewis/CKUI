import Foundation
import CareKit

let thisMorning = Calendar.current.startOfDay(for: Date())
let store = OCKStore(name: "v1")
let sched = OCKSchedule(composing: [.init(start: thisMorning, end: nil, interval: DateComponents(day: 1))])
let manager = OCKSynchronizedStoreManager(wrapping: store)

