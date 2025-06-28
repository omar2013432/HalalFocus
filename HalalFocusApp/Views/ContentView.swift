import SwiftUI

struct ContentView: View {
    @EnvironmentObject var prayerManager: PrayerTimesManager
    @EnvironmentObject var screenTimeManager: ScreenTimeManager

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Welcome to HalalFocus")
                    .font(.title)
                    .padding()

                List(prayerManager.prayerTimes) { prayer in
                    HStack {
                        Text(prayer.name)
                        Spacer()
                        Text(prayer.timeFormatted)
                    }
                }

                NavigationLink("Settings", destination: SettingsView())
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PrayerTimesManager())
            .environmentObject(ScreenTimeManager())
    }
}
