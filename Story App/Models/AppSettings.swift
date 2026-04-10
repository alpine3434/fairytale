import Foundation
import SwiftUI
import Observation

enum AppLanguage: String, CaseIterable, Codable, Sendable {
    case english = "english"
    case turkish = "turkish"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .turkish: return "Türkçe"
        }
    }
    var ttsCode: String {
        switch self {
        case .english: return "en-US"
        case .turkish: return "tr-TR"
        }
    }
    var flag: String {
        switch self {
        case .english: return "🇬🇧"
        case .turkish: return "🇹🇷"
        }
    }
}

@Observable
final class AppSettings {
    static let shared = AppSettings()

    var language: AppLanguage         = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "appLanguage") ?? "") ?? .turkish {
        didSet { UserDefaults.standard.set(language.rawValue, forKey: "appLanguage") }
    }
    var subtitleLanguage: AppLanguage = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "subtitleLanguage") ?? "") ?? .english {
        didSet { UserDefaults.standard.set(subtitleLanguage.rawValue, forKey: "subtitleLanguage") }
    }
    var showSubtitle: Bool            = UserDefaults.standard.object(forKey: "showSubtitle") as? Bool ?? true {
        didSet { UserDefaults.standard.set(showSubtitle, forKey: "showSubtitle") }
    }
    var readingSpeed: Float           = UserDefaults.standard.object(forKey: "readingSpeed") as? Float ?? 0.45 {
        didSet { UserDefaults.standard.set(readingSpeed, forKey: "readingSpeed") }
    }
    var isDarkMode: Bool              = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool ?? false {
        didSet { UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode") }
    }
    var parentalControlsEnabled: Bool = UserDefaults.standard.object(forKey: "parentalControlsEnabled") as? Bool ?? false {
        didSet { UserDefaults.standard.set(parentalControlsEnabled, forKey: "parentalControlsEnabled") }
    }
    var fontSize: CGFloat             = CGFloat(UserDefaults.standard.object(forKey: "fontSize") as? Double ?? 18) {
        didSet { UserDefaults.standard.set(Double(fontSize), forKey: "fontSize") }
    }

    private init() {}
}
