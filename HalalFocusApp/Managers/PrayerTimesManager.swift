import Foundation
import CoreLocation
import UserNotifications

struct PrayerTime: Identifiable {
    let id = UUID()
    let name: String
    let date: Date

    var timeFormatted: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

class PrayerTimesManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var prayerTimes: [PrayerTime] = []
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        fetchPrayerTimes(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        manager.stopUpdatingLocation()
    }

    func fetchPrayerTimes(lat: Double, lon: Double) {
        let timestamp = Int(Date().timeIntervalSince1970)
        guard let url = URL(string: "https://api.aladhan.com/v1/timings/\(timestamp)?latitude=\(lat)&longitude=\(lon)&method=2") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataDict = json["data"] as? [String: Any],
                  let timings = dataDict["timings"] as? [String: String] else { return }

            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"

            DispatchQueue.main.async {
                self.prayerTimes = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"].compactMap { name in
                    if let timeString = timings[name],
                       let date = formatter.date(from: String(timeString.prefix(5))) {
                        return PrayerTime(name: name, date: date)
                    }
                    return nil
                }
                self.scheduleNotifications()
            }
        }.resume()
    }

    func scheduleNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            guard granted else { return }
            for prayer in self.prayerTimes {
                let before = prayer.date.addingTimeInterval(-300)
                let after = prayer.date.addingTimeInterval(300)
                self.scheduleNotification(at: before, title: "Time for \(prayer.name)")
                self.scheduleNotification(at: after, title: "Avoid distractions after \(prayer.name)")
            }
        }
    }

    private func scheduleNotification(at date: Date, title: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
