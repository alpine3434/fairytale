import SwiftUI

struct BookCardView: View {
    let book: Book
    @ObservedObject private var settings = AppSettings.shared
    @ObservedObject private var progress = UserProgress.shared
    @ObservedObject private var purchases = PurchaseManager.shared

    var isLocked: Bool { !purchases.canRead(book) }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                // Cover
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(book.coverColor.gradient)
                        .aspectRatio(2/3, contentMode: .fit)

                    VStack(spacing: 8) {
                        Text(book.coverEmoji)
                            .font(.system(size: 44))
                        if isLocked {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }

                    if progress.isRead(book) {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .background(Circle().fill(.white).padding(2))
                                    .padding(6)
                            }
                        }
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
                .shadow(color: book.coverColor.opacity(0.4), radius: 8, x: 0, y: 4)

                // Title
                Text(book.title(in: settings.language))
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                    .padding(.top, 8)
                    .padding(.horizontal, 4)

                // Category badge
                HStack(spacing: 3) {
                    Text(book.category.emoji)
                        .font(.system(size: 9))
                    Text(settings.language == .english ? book.category.nameEN : book.category.nameTR)
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(book.category.color)
                }
                .padding(.top, 3)
            }

            // Favorite heart
            if progress.isFavorite(book) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                    .padding(6)
            }
        }
    }
}
