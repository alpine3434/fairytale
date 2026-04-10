import SwiftUI

struct AchievementsView: View {
    @ObservedObject private var progress = UserProgress.shared
    @ObservedObject private var settings = AppSettings.shared

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Stars header
                    starsHeader

                    // Stats
                    statsRow

                    // Achievement grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(Achievement.allCases, id: \.self) { achievement in
                            AchievementCard(achievement: achievement,
                                           earned: progress.hasAchievement(achievement))
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationTitle(settings.language == .english ? "Achievements" : "Başarılar")
            .background(Color(.systemGroupedBackground))
        }
    }

    private var starsHeader: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom))
                    .frame(width: 100, height: 100)
                    .shadow(color: .yellow.opacity(0.5), radius: 12, y: 6)
                VStack(spacing: 2) {
                    Text("⭐")
                        .font(.system(size: 32))
                    Text("\(progress.totalStars)")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            Text(settings.language == .english ? "Total Stars" : "Toplam Yıldız")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }

    private var statsRow: some View {
        HStack(spacing: 0) {
            statItem(settings.language == .english ? "Read" : "Okunan",
                     "\(progress.readBookIDs.count)", "📖")
            Divider().frame(height: 40)
            statItem(settings.language == .english ? "Favorites" : "Favori",
                     "\(progress.favoriteBookIDs.count)", "❤️")
            Divider().frame(height: 40)
            statItem(settings.language == .english ? "Badges" : "Rozet",
                     "\(progress.earnedAchievements.count)/\(Achievement.allCases.count)", "🏅")
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
        .padding(.horizontal)
    }

    private func statItem(_ label: String, _ value: String, _ emoji: String) -> some View {
        VStack(spacing: 4) {
            Text(emoji).font(.title2)
            Text(value).font(.system(size: 18, weight: .bold))
            Text(label).font(.caption).foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Achievement Card
struct AchievementCard: View {
    let achievement: Achievement
    let earned: Bool
    @ObservedObject private var settings = AppSettings.shared

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(earned
                          ? LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                          : LinearGradient(colors: [Color(.systemGray5), Color(.systemGray4)], startPoint: .top, endPoint: .bottom))
                    .frame(width: 60, height: 60)
                    .shadow(color: earned ? .yellow.opacity(0.4) : .clear, radius: 8, y: 3)
                Text(achievement.emoji)
                    .font(.system(size: 28))
                    .grayscale(earned ? 0 : 1)
            }

            Text(settings.language == .english ? achievement.titleEN : achievement.titleTR)
                .font(.system(size: 13, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(earned ? .primary : .secondary)

            Text(settings.language == .english ? achievement.descEN : achievement.descTR)
                .font(.system(size: 10))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .lineLimit(2)

            HStack(spacing: 2) {
                Image(systemName: "star.fill")
                    .font(.system(size: 9))
                Text("+\(achievement.stars)")
                    .font(.system(size: 11, weight: .semibold))
            }
            .foregroundColor(earned ? .yellow : .secondary)
        }
        .padding(14)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(earned ? Color.yellow.opacity(0.4) : Color.clear, lineWidth: 1.5)
        )
        .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        .opacity(earned ? 1 : 0.6)
    }
}
