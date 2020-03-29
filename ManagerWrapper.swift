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
            return self[T.self]
        }
        set {
            self[T.self] = newValue
        }
    }
}

public struct T: EnvironmentKey {
    public static let defaultValue: OCKSynchronizedStoreManager = OCKSynchronizedStoreManager(wrapping: store)
}
