import Foundation

class VerseManager: ObservableObject {
    @Published var currentVerse: String = ""

    private let verses: [String] = [
        "Indeed, prayer prohibits immorality and wrongdoing." ,
        "So remember Me; I will remember you." ,
        "And seek help through patience and prayer." ,
        "Verily, in the remembrance of Allah do hearts find rest." ,
        "And establish prayer and give zakah." 
    ]

    func randomVerse() -> String {
        verses.randomElement() ?? ""
    }

    func loadVerse() {
        currentVerse = randomVerse()
    }
}
