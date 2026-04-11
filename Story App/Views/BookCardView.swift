import SwiftUI

struct BookCardView: View {
    let book: Book
    var settings = AppSettings.shared
    var progress = UserProgress.shared
    var purchases = PurchaseManager.shared

    var isLocked: Bool { !purchases.canRead(book) }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                // Cover
                ZStack(alignment: .bottomTrailing) {
                    coverImage
                        .aspectRatio(2/3, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: book.coverColor.opacity(0.4), radius: 8, x: 0, y: 4)

                    // Kilit ikonu
                    if isLocked {
                        ZStack {
                            Color.black.opacity(0.45)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            Image(systemName: "lock.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                    }

                    // Okundu işareti
                    if progress.isRead(book) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .background(Circle().fill(.white).padding(2))
                            .padding(6)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )

                // Başlık
                Text(book.title(in: settings.language))
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                    .padding(.top, 8)
                    .padding(.horizontal, 4)

                // Kategori
                HStack(spacing: 3) {
                    Text(book.category.emoji).font(.system(size: 9))
                    Text(settings.language == .english ? book.category.nameEN : book.category.nameTR)
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(book.category.color)
                }
                .padding(.top, 3)
            }

            // Favori kalp
            if progress.isFavorite(book) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                    .padding(6)
            }
        }
    }

    // Gerçek kapak varsa onu, yoksa emoji+renk
    @ViewBuilder
    private var coverImage: some View {
        if let imageName = book.coverImageName, UIImage(named: imageName) != nil {
            Image(imageName)
                .resizable()
                .scaledToFill()
        } else {
            ZStack {
                book.coverColor.gradient
                Text(book.coverEmoji)
                    .font(.system(size: 44))
            }
        }
    }
}
