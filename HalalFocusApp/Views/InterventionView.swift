import SwiftUI
import FamilyControls

struct InterventionView: View {
    @EnvironmentObject var verseManager: VerseManager
    @EnvironmentObject var screenTimeManager: ScreenTimeManager
    @EnvironmentObject var logManager: LoggingManager
    let appToken: ApplicationToken
    let appName: String

    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                Text(verseManager.currentVerse)
                    .padding()
            }
            Button("I've Read It") {
                logManager.log("User read verse to open \(appName)")
                screenTimeManager.deactivateShielding()
                verseManager.loadVerse()
                // open the app after releasing shield
            }
        }
        .onAppear { verseManager.loadVerse() }
        .navigationTitle(appName)
        .padding()
    }
}
