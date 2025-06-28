# HalalFocus

HalalFocus is a minimal iOS app written in SwiftUI that helps Muslims stay focused on worship by limiting distractions. It fetches daily prayer times based on location, schedules reminders before and after each prayer, and intercepts the launch of distracting apps using Screen Time APIs.

When a blocked app like TikTok or Instagram is opened, HalalFocus displays a verse from the Quran. The user must scroll to the bottom and tap **"I've Read It"** before the app becomes accessible again. All interactions are logged locally.

## Building
Open the `HalalFocusApp` folder in Xcode (iOS 16+ required) and build the project. The app uses the **FamilyControls**, **ManagedSettings**, and **DeviceActivity** frameworks.
