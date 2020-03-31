import SwiftUI
import CareKit

struct ManagerWrapper<Content: View>: View {
    @Environment(\.manager) var manager: OCKSynchronizedStoreManager
    var content: (OCKSynchronizedStoreManager) -> Content
    
    var body: some View {
        content(manager)
    }
}

extension EnvironmentValues {
    var manager: OCKSynchronizedStoreManager {
        get {
            return self[SynchronizedStoreManagerKey.self]
        }
        set {
            self[SynchronizedStoreManagerKey.self] = newValue
        }
    }
}

public struct SynchronizedStoreManagerKey: EnvironmentKey {
    public static let defaultValue: OCKSynchronizedStoreManager = OCKSynchronizedStoreManager(wrapping: OCKStore(name: "default"))
}
