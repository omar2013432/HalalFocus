import Foundation

class LoggingManager: ObservableObject {
    func log(_ message: String) {
        let log = "\(Date()): \(message)\n"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("halalfocus.log")
            if FileManager.default.fileExists(atPath: fileURL.path) {
                if let handle = try? FileHandle(forWritingTo: fileURL) {
                    handle.seekToEndOfFile()
                    handle.write(log.data(using: .utf8)!)
                    handle.closeFile()
                }
            } else {
                try? log.write(to: fileURL, atomically: true, encoding: .utf8)
            }
        }
    }
}
