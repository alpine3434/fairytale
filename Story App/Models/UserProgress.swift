import Foundation
import SwiftUI
import Observation

// MARK: - Achievement
enum Achievement: String, CaseIterable, Codable, Sendable {
    case firstBook      = "firstBook"
    case fiveBooks      = "fiveBooks"
    case tenBooks       = "tenBooks"
    case allFree        = "allFree"
    case firstFavorite  = "firstFavorite"
    case nightOwl       = "nightOwl"
    case speedReader    = "speedReader"
    case bookworm       = "bookworm"
    case allBooks       = "allBooks"

    var titleEN: String {
        switch self {
        case .firstBook:     return "First Story"
        case .fiveBooks:     return "Story Starter"
        case .tenBooks:      return "Bookworm"
        case .allFree:       return "Free Explorer"
        case .firstFavorite: return "Heartthrob"
        case .nightOwl:      return "Night Owl"
        case .speedReader:   return "Speed Reader"
        case .bookworm:      return "Super Reader"
        case .allBooks:      return "Grand Master"
        }
    }
    var titleTR: String {
        switch self {
        case .firstBook:     return "İlk Masal"
        case .fiveBooks:     return "Masal Başlangıcı"
        case .tenBooks:      return "Kitap Kurdu"
        case .allFree:       return "Özgür Kaşif"
        case .firstFavorite: return "Favorim"
        case .nightOwl:      return "Gece Kuşu"
        case .speedReader:   return "Hızlı Okuyucu"
        case .bookworm:      return "Süper Okuyucu"
        case .allBooks:      return "Büyük Usta"
        }
    }
    var descEN: String {
        switch self {
        case .firstBook:     return "Read your first story"
        case .fiveBooks:     return "Read 5 stories"
        case .tenBooks:      return "Read 10 stories"
        case .allFree:       return "Read all 15 free stories"
        case .firstFavorite: return "Add your first favorite"
        case .nightOwl:      return "Read after 9 PM"
        case .speedReader:   return "Finish a story in one session"
        case .bookworm:      return "Read 25 stories"
        case .allBooks:      return "Read all 58 stories!"
        }
    }
    var descTR: String {
        switch self {
        case .firstBook:     return "İlk masalını oku"
        case .fiveBooks:     return "5 masal oku"
        case .tenBooks:      return "10 masal oku"
        case .allFree:       return "15 ücretsiz masalı oku"
        case .firstFavorite: return "İlk favorini ekle"
        case .nightOwl:      return "Gece 21'den sonra oku"
        case .speedReader:   return "Bir oturumda masal bitir"
        case .bookworm:      return "25 masal oku"
        case .allBooks:      return "58 masalın hepsini oku!"
        }
    }
    var emoji: String {
        switch self {
        case .firstBook:     return "📖"
        case .fiveBooks:     return "⭐"
        case .tenBooks:      return "🌟"
        case .allFree:       return "🆓"
        case .firstFavorite: return "❤️"
        case .nightOwl:      return "🦉"
        case .speedReader:   return "⚡"
        case .bookworm:      return "🐛"
        case .allBooks:      return "🏆"
        }
    }
    var stars: Int {
        switch self {
        case .firstBook:     return 1
        case .fiveBooks:     return 3
        case .tenBooks:      return 5
        case .allFree:       return 8
        case .firstFavorite: return 1
        case .nightOwl:      return 2
        case .speedReader:   return 2
        case .bookworm:      return 10
        case .allBooks:      return 25
        }
    }
}

// MARK: - UserProgress
@Observable
final class UserProgress {
    static let shared = UserProgress()

    var favoriteBookIDs: Set<String> = Set(UserDefaults.standard.stringArray(forKey: "favoriteBookIDs") ?? []) {
        didSet { UserDefaults.standard.set(Array(favoriteBookIDs), forKey: "favoriteBookIDs") }
    }
    var readBookIDs: Set<String> = Set(UserDefaults.standard.stringArray(forKey: "readBookIDs") ?? []) {
        didSet { UserDefaults.standard.set(Array(readBookIDs), forKey: "readBookIDs") }
    }
    var bookmarks: [String: Int] = {
        (try? JSONDecoder().decode([String: Int].self,
            from: UserDefaults.standard.data(forKey: "bookmarks") ?? Data())) ?? [:]
    }() {
        didSet {
            if let data = try? JSONEncoder().encode(bookmarks) {
                UserDefaults.standard.set(data, forKey: "bookmarks")
            }
        }
    }
    var earnedAchievements: Set<String> = Set(UserDefaults.standard.stringArray(forKey: "earnedAchievements") ?? []) {
        didSet { UserDefaults.standard.set(Array(earnedAchievements), forKey: "earnedAchievements") }
    }
    var totalStars: Int = UserDefaults.standard.integer(forKey: "totalStars") {
        didSet { UserDefaults.standard.set(totalStars, forKey: "totalStars") }
    }

    private init() {}

    // MARK: Helpers
    func isFavorite(_ book: Book) -> Bool { favoriteBookIDs.contains(book.id.uuidString) }

    func toggleFavorite(_ book: Book) {
        let key = book.id.uuidString
        if favoriteBookIDs.contains(key) {
            favoriteBookIDs.remove(key)
        } else {
            favoriteBookIDs.insert(key)
            checkAchievements()
        }
    }

    func markRead(_ book: Book) {
        readBookIDs.insert(book.id.uuidString)
        checkAchievements()
    }

    func isRead(_ book: Book) -> Bool { readBookIDs.contains(book.id.uuidString) }
    func bookmark(for book: Book) -> Int { bookmarks[book.id.uuidString] ?? 0 }
    func setBookmark(_ page: Int, for book: Book) { bookmarks[book.id.uuidString] = page }
    func hasAchievement(_ a: Achievement) -> Bool { earnedAchievements.contains(a.rawValue) }

    func checkAchievements() {
        let count = readBookIDs.count
        let checks: [(Achievement, Bool)] = [
            (.firstBook,     count >= 1),
            (.fiveBooks,     count >= 5),
            (.tenBooks,      count >= 10),
            (.bookworm,      count >= 25),
            (.allBooks,      count >= 58),
            (.firstFavorite, !favoriteBookIDs.isEmpty),
            (.allFree,       Book.allBooks.filter(\.isFree).allSatisfy { isRead($0) }),
        ]
        for (achievement, condition) in checks where condition && !hasAchievement(achievement) {
            earnedAchievements.insert(achievement.rawValue)
            totalStars += achievement.stars
        }
    }

    func checkNightOwl() {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 21 && !hasAchievement(.nightOwl) {
            earnedAchievements.insert(Achievement.nightOwl.rawValue)
            totalStars += Achievement.nightOwl.stars
        }
    }
}
