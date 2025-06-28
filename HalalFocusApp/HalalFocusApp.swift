import SwiftUI
import FamilyControls
import DeviceActivity

@main
struct HalalFocusApp: App {
    @StateObject private var prayerManager = PrayerTimesManager()
    @StateObject private var screenTimeManager = ScreenTimeManager()
    @StateObject private var verseManager = VerseManager()
    @StateObject private var logManager = LoggingManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(prayerManager)
                .environmentObject(screenTimeManager)
                .environmentObject(verseManager)
                .environmentObject(logManager)
        }
    }
}
