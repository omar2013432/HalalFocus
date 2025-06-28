import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity

class ScreenTimeManager: ObservableObject {
    private let store = ManagedSettingsStore()
    @Published var selection = FamilyActivitySelection()

    func requestAuthorization() {
        Task { try? await AuthorizationCenter.shared.requestAuthorization() }
    }

    func presentActivityPicker() {
        let picker = FamilyActivityPicker(selection: $selection)
        // In a real app, present this view modally
    }

    func activateShielding() {
        store.shield.applications = selection.applicationTokens
    }

    func deactivateShielding() {
        store.shield.applications = []
    }
}
