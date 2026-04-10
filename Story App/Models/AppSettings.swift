import Foundation
import SwiftUI
import Combine

enum AppLanguage: String, CaseIterable, Codable {
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

class AppSettings: ObservableObject {
    static let shared = AppSettings()

    @Published var language: AppLanguage {
        didSet { UserDefaults.standard.set(language.rawValue, forKey: "appLanguage") }
    }
    @Published var subtitleLanguage: AppLanguage {
        didSet { UserDefaults.standard.set(subtitleLanguage.rawValue, forKey: "subtitleLanguage") }
    }
    @Published var showSubtitle: Bool {
        didSet { UserDefaults.standard.set(showSubtitle, forKey: "showSubtitle") }
    }
    @Published var readingSpeed: Float {
        didSet { UserDefaults.standard.set(readingSpeed, forKey: "readingSpeed") }
    }
    @Published var isDarkMode: Bool {
        didSet { UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode") }
    }
    @Published var parentalControlsEnabled: Bool {
        didSet { UserDefaults.standard.set(parentalControlsEnabled, forKey: "parentalControlsEnabled") }
    }
    @Published var fontSize: CGFloat {
        didSet { UserDefaults.standard.set(Double(fontSize), forKey: "fontSize") }
    }

    private init() {
        let ud = UserDefaults.standard
        self.language = AppLanguage(rawValue: ud.string(forKey: "appLanguage") ?? "") ?? .turkish
        self.subtitleLanguage = AppLanguage(rawValue: ud.string(forKey: "subtitleLanguage") ?? "") ?? .english
        self.showSubtitle = ud.object(forKey: "showSubtitle") as? Bool ?? true
        self.readingSpeed = ud.object(forKey: "readingSpeed") as? Float ?? 0.45
        self.isDarkMode = ud.object(forKey: "isDarkMode") as? Bool ?? false
        self.parentalControlsEnabled = ud.object(forKey: "parentalControlsEnabled") as? Bool ?? false
        self.fontSize = CGFloat(ud.object(forKey: "fontSize") as? Double ?? 18)
    }
}
