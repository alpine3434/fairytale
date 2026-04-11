import SwiftUI
import AVFoundation

struct ReaderView: View {
    let book: Book
    @Environment(\.dismiss) private var dismiss
    @Bindable private var settings = AppSettings.shared
    var tts = TTSService.shared
    var progress = UserProgress.shared

    @State private var currentPage: Int = 0
    @State private var showControls = true
    @State private var showBookmarkConfirm = false
    @State private var didFinish = false

    private var totalPages: Int { book.content(in: settings.language).count }
    private var currentText: String {
        let pages = book.content(in: settings.language)
        guard currentPage < pages.count else { return "" }
        return pages[currentPage]
    }
    private var subtitleText: String {
        let pages = book.content(in: settings.subtitleLanguage)
        guard settings.showSubtitle, currentPage < pages.count else { return "" }
        return pages[currentPage]
    }
    private var progressValue: Double {
        totalPages > 1 ? Double(currentPage) / Double(totalPages - 1) : 1
    }

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient

                VStack(spacing: 0) {
                    progressBar
                    pageContent
                    Spacer()
                    controlBar
                }
            }
            .navigationTitle(book.title(in: settings.language))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarItems }
            .onAppear {
                currentPage = progress.bookmark(for: book)
                progress.checkNightOwl()
            }
            .onDisappear {
                tts.stop()
                progress.setBookmark(currentPage, for: book)
            }
            .alert(settings.language == .english ? "Bookmark saved!" : "Yer imi kaydedildi!",
                   isPresented: $showBookmarkConfirm) {
                Button("OK", role: .cancel) {}
            }
            .preferredColorScheme(settings.isDarkMode ? .dark : nil)
        }
    }

    // MARK: - Background
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [book.coverColor.opacity(0.15), Color(.systemBackground)],
            startPoint: .top, endPoint: .center
        ).ignoresSafeArea()
    }

    // MARK: - Progress Bar
    private var progressBar: some View {
        VStack(spacing: 4) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(.systemGray5))
                    RoundedRectangle(cornerRadius: 3)
                        .fill(book.coverColor)
                        .frame(width: geo.size.width * progressValue)
                        .animation(.easeInOut(duration: 0.3), value: progressValue)
                }
            }
            .frame(height: 6)
            .padding(.horizontal)

            HStack {
                Text("\(currentPage + 1) / \(totalPages)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Text(settings.language == .english
                     ? "\(book.readingTimeMinutes) min read"
                     : "\(book.readingTimeMinutes) dk okuma")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
    }

    // MARK: - Page Content
    private var pageContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Cover emoji
                if currentPage == 0 {
                    HStack {
                        Spacer()
                        VStack(spacing: 12) {
                            Text(book.coverEmoji)
                                .font(.system(size: 72))
                            Text(book.title(in: settings.language))
                                .font(.title2.bold())
                                .multilineTextAlignment(.center)
                                .foregroundColor(book.coverColor)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 8)
                }

                // Main text (highlighted word)
                HighlightedTextView(
                    text: currentText,
                    highlight: tts.currentParagraphIndex == currentPage ? tts.currentWordRange : NSRange(location: 0, length: 0),
                    fontSize: settings.fontSize,
                    highlightColor: book.coverColor
                )

                // Subtitle
                if !subtitleText.isEmpty {
                    Divider()
                    Text(subtitleText)
                        .font(.system(size: settings.fontSize - 3))
                        .foregroundColor(.secondary)
                        .italic()
                }
            }
            .padding(20)
        }
        .gesture(
            DragGesture(minimumDistance: 30)
                .onEnded { value in
                    if value.translation.width < -50 { goToNextPage() }
                    if value.translation.width > 50  { goToPrevPage() }
                }
        )
        .onTapGesture {
            withAnimation { showControls.toggle() }
        }
    }

    // MARK: - Control Bar
    private var controlBar: some View {
        VStack(spacing: 12) {
            // TTS speed slider
            if showControls {
                HStack {
                    Image(systemName: "tortoise.fill").foregroundColor(.secondary)
                    Slider(value: $settings.readingSpeed, in: 0.2...0.6, step: 0.05)
                        .tint(book.coverColor)
                    Image(systemName: "hare.fill").foregroundColor(.secondary)
                }
                .padding(.horizontal, 24)
            }

            // Navigation + TTS buttons
            HStack(spacing: 28) {
                // Prev
                navButton(icon: "chevron.left", enabled: currentPage > 0) { goToPrevPage() }

                // Play/Pause
                Button {
                    tts.togglePlay(
                        paragraphs: book.content(in: settings.language),
                        language: settings.language,
                        speed: settings.readingSpeed,
                        currentPage: currentPage
                    )
                } label: {
                    ZStack {
                        Circle()
                            .fill(book.coverColor)
                            .frame(width: 64, height: 64)
                        Image(systemName: tts.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
                    .shadow(color: book.coverColor.opacity(0.5), radius: 8, y: 4)
                }

                // Next
                navButton(icon: "chevron.right", enabled: currentPage < totalPages - 1) { goToNextPage() }
            }
            .padding(.bottom, 20)
        }
        .padding(.top, 8)
        .background(.ultraThinMaterial)
    }

    private func navButton(icon: String, enabled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(enabled ? .primary : .secondary)
                .frame(width: 44, height: 44)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        }
        .disabled(!enabled)
    }

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button { dismiss() } label: { Image(systemName: "xmark") }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack(spacing: 16) {
                // Favorite
                Button {
                    progress.toggleFavorite(book)
                } label: {
                    Image(systemName: progress.isFavorite(book) ? "heart.fill" : "heart")
                        .foregroundColor(progress.isFavorite(book) ? .red : .primary)
                }
                // Bookmark
                Button {
                    progress.setBookmark(currentPage, for: book)
                    showBookmarkConfirm = true
                } label: {
                    Image(systemName: "bookmark.fill")
                }
            }
        }
    }

    // MARK: - Navigation
    private func goToNextPage() {
        guard currentPage < totalPages - 1 else {
            progress.markRead(book)
            didFinish = true
            return
        }
        withAnimation(.easeInOut(duration: 0.2)) { currentPage += 1 }
        if tts.isPlaying {
            tts.play(
                paragraphs: book.content(in: settings.language),
                language: settings.language,
                speed: settings.readingSpeed,
                from: currentPage
            )
        }
    }

    private func goToPrevPage() {
        guard currentPage > 0 else { return }
        withAnimation(.easeInOut(duration: 0.2)) { currentPage -= 1 }
    }
}

// MARK: - Highlighted Text
struct HighlightedTextView: View {
    let text: String
    let highlight: NSRange
    let fontSize: CGFloat
    let highlightColor: Color

    var body: some View {
        Text(attributedText)
            .font(.system(size: fontSize, design: .rounded))
            .lineSpacing(8)
            .animation(.easeInOut(duration: 0.1), value: highlight.location)
    }

    private var attributedText: AttributedString {
        var attr = AttributedString(text)
        attr.foregroundColor = .primary
        if highlight.length > 0,
           let range = Range(highlight, in: text),
           let attrRange = Range(range, in: attr) {
            attr[attrRange].backgroundColor = highlightColor.opacity(0.35)
            attr[attrRange].foregroundColor = highlightColor
        }
        return attr
    }
}
