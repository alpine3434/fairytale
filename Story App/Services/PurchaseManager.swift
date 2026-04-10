import Foundation
import SwiftUI

class PurchaseManager: ObservableObject {
    static let shared = PurchaseManager()

    @Published var isPremium: Bool {
        didSet { UserDefaults.standard.set(isPremium, forKey: "isPremium") }
    }

    private init() {
        self.isPremium = UserDefaults.standard.bool(forKey: "isPremium")
    }

    func canRead(_ book: Book) -> Bool {
        book.isFree || isPremium
    }

    // Simulate purchase (replace with StoreKit in production)
    func purchasePremium() {
        withAnimation { isPremium = true }
    }

    func restorePurchases() {
        // StoreKit restore would go here
        withAnimation { isPremium = true }
    }

    func unlockForPreview() {
        withAnimation { isPremium = true }
    }
}
