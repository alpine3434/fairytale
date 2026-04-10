import Foundation
import SwiftUI
import Observation

@Observable
final class PurchaseManager {
    static let shared = PurchaseManager()

    var isPremium: Bool = UserDefaults.standard.bool(forKey: "isPremium") {
        didSet { UserDefaults.standard.set(isPremium, forKey: "isPremium") }
    }

    private init() {}

    func canRead(_ book: Book) -> Bool { book.isFree || isPremium }

    func purchasePremium() {
        withAnimation { isPremium = true }
    }

    func restorePurchases() {
        withAnimation { isPremium = true }
    }
}
