import SwiftUI

struct BookshelfView: View {
    @ObservedObject private var settings = AppSettings.shared
    @ObservedObject private var purchases = PurchaseManager.shared

    @State private var searchText = ""
    @State private var selectedCategory: BookCategory? = nil
    @State private var showFavoritesOnly = false
    @State private var selectedBook: Book? = nil
    @State private var showPaywall = false

    private let columns_iPhone = [GridItem(.flexible()), GridItem(.flexible())]
    private let columns_iPad   = [GridItem(.flexible()), GridItem(.flexible()),
                                   GridItem(.flexible()), GridItem(.flexible())]

    var filteredBooks: [Book] {
        var books = Book.allBooks
        if showFavoritesOnly {
            let favs = UserProgress.shared.favoriteBookIDs
            books = books.filter { favs.contains($0.id.uuidString) }
        }
        if let cat = selectedCategory {
            books = books.filter { $0.category == cat }
        }
        if !searchText.isEmpty {
            books = books.filter {
                $0.titleEN.localizedCaseInsensitiveContains(searchText) ||
                $0.titleTR.localizedCaseInsensitiveContains(searchText)
            }
        }
        return books
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Category filter pills
                categoryPills

                // Search
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.bottom, 8)

                // Grid
                GeometryReader { geo in
                    let columns = geo.size.width > 600 ? columns_iPad : columns_iPhone
                    ScrollView {
                        if filteredBooks.isEmpty {
                            emptyState
                        } else {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(filteredBooks) { book in
                                    Button {
                                        if purchases.canRead(book) {
                                            selectedBook = book
                                        } else {
                                            showPaywall = true
                                        }
                                    } label: {
                                        BookCardView(book: book)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle(settings.language == .english ? "Story Treasury" : "Masal Hazinesi")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showFavoritesOnly.toggle()
                    } label: {
                        Image(systemName: showFavoritesOnly ? "heart.fill" : "heart")
                            .foregroundColor(showFavoritesOnly ? .red : .primary)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill").foregroundColor(.yellow)
                        Text("\(UserProgress.shared.totalStars)")
                            .fontWeight(.bold)
                    }
                    .font(.subheadline)
                }
            }
            .sheet(item: $selectedBook) { book in
                ReaderView(book: book)
            }
            .sheet(isPresented: $showPaywall) {
                PaywallView()
            }
        }
    }

    // MARK: - Subviews
    private var categoryPills: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                pill(nil, "Tümü", "📚")
                ForEach(BookCategory.allCases, id: \.self) { cat in
                    pill(cat, settings.language == .english ? cat.nameEN : cat.nameTR, cat.emoji)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }

    private func pill(_ cat: BookCategory?, _ name: String, _ emoji: String) -> some View {
        let selected = selectedCategory == cat
        return Button {
            withAnimation(.spring(response: 0.3)) {
                selectedCategory = cat
            }
        } label: {
            HStack(spacing: 4) {
                Text(emoji).font(.system(size: 13))
                Text(name).font(.system(size: 13, weight: .medium))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(selected ? Color.accentColor : Color(.systemGray5))
            .foregroundColor(selected ? .white : .primary)
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Text("📚")
                .font(.system(size: 60))
            Text(settings.language == .english ? "No stories found" : "Masal bulunamadı")
                .font(.title3)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 80)
    }
}

// MARK: - Search Bar
struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.secondary)
            TextField("Masal ara... / Search...", text: $text)
                .textFieldStyle(.plain)
            if !text.isEmpty {
                Button { text = "" } label: {
                    Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Paywall
struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var purchases = PurchaseManager.shared
    @ObservedObject private var settings = AppSettings.shared

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                Text("🌟")
                    .font(.system(size: 80))
                Text(settings.language == .english ? "Unlock All 58 Stories!" : "58 Masalın Hepsini Aç!")
                    .font(.title.bold())
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 12) {
                    featureRow("📖", settings.language == .english ? "43 more amazing stories" : "43 muhteşem masal daha")
                    featureRow("🎙️", settings.language == .english ? "Text-to-speech in both languages" : "İki dilde sesli okuma")
                    featureRow("🔖", settings.language == .english ? "Bookmarks & favorites" : "Yer imleri ve favoriler")
                    featureRow("🏆", settings.language == .english ? "All achievements & badges" : "Tüm başarılar ve rozetler")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal)

                Button {
                    purchases.purchasePremium()
                    dismiss()
                } label: {
                    Text(settings.language == .english ? "Unlock Premium" : "Premium'a Geç")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(colors: [.orange, .yellow], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(16)
                        .padding(.horizontal)
                }

                Button {
                    purchases.restorePurchases()
                    dismiss()
                } label: {
                    Text(settings.language == .english ? "Restore Purchases" : "Satın Alımları Geri Yükle")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }
                Spacer()
            }
            .navigationTitle(settings.language == .english ? "Go Premium" : "Premium")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { dismiss() } label: { Image(systemName: "xmark") }
                }
            }
        }
    }

    private func featureRow(_ emoji: String, _ text: String) -> some View {
        HStack(spacing: 12) {
            Text(emoji)
            Text(text).font(.subheadline)
            Spacer()
            Image(systemName: "checkmark").foregroundColor(.green)
        }
    }
}
