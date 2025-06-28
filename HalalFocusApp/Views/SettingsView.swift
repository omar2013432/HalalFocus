import SwiftUI
import FamilyControls

struct SettingsView: View {
    @EnvironmentObject var screenTimeManager: ScreenTimeManager

    var body: some View {
        VStack(spacing: 20) {
            Button("Authorize Screen Time") {
                screenTimeManager.requestAuthorization()
            }
            Button("Select Distraction Apps") {
                screenTimeManager.presentActivityPicker()
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ScreenTimeManager())
    }
}
