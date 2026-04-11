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
                // Kapak
                ZStack(alignment: .bottomTrailing) {
                    coverImage
                        .aspectRatio(2/3, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: book.coverColor.opacity(0.4), radius: 8, x: 0, y: 4)

                    // Kilit
                    if isLocked {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.45))
                            .overlay(
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            )
                    }

                    // Okundu
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

    @ViewBuilder
    private var coverImage: some View {
        if let imageName = book.coverImageName {
            Image(imageName)
                .resizable()
                .scaledToFill()
        } else {
            ZStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [book.coverColor, book.coverColor.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                Text(book.coverEmoji)
                    .font(.system(size: 44))
            }
        }
    }
}
