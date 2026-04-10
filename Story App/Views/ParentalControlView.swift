import SwiftUI

struct ParentalControlView: View {
    @ObservedObject private var settings = AppSettings.shared
    @Environment(\.dismiss) private var dismiss

    @State private var a = Int.random(in: 2...12)
    @State private var b = Int.random(in: 2...12)
    @State private var answer = ""
    @State private var attempts = 0
    @State private var unlocked = false
    @State private var showError = false

    var question: String { "\(a) × \(b) = ?" }
    var correct: Int    { a * b }

    var body: some View {
        NavigationStack {
            if unlocked {
                unlockedContent
            } else {
                lockScreen
            }
        }
    }

    // MARK: - Lock Screen
    private var lockScreen: some View {
        VStack(spacing: 28) {
            Spacer()

            Image(systemName: "lock.shield.fill")
                .font(.system(size: 70))
                .foregroundStyle(.orange)

            Text(settings.language == .english
                 ? "Parental Controls"
                 : "Ebeveyn Kontrolü")
                .font(.title.bold())

            Text(settings.language == .english
                 ? "Solve the puzzle to access settings"
                 : "Ayarlara erişmek için bulmacayı çöz")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            // Math puzzle
            VStack(spacing: 16) {
                Text(question)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.orange)

                TextField("?", text: $answer)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 32, weight: .bold))
                    .frame(width: 100, height: 60)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                if showError {
                    Text(settings.language == .english ? "Try again!" : "Tekrar dene!")
                        .foregroundColor(.red)
                        .font(.subheadline)
                }
            }

            Button {
                checkAnswer()
            } label: {
                Text(settings.language == .english ? "Check Answer" : "Yanıtı Kontrol Et")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(14)
                    .padding(.horizontal)
            }

            Text(settings.language == .english
                 ? "Attempts: \(attempts)"
                 : "Deneme: \(attempts)")
                .font(.caption)
                .foregroundColor(.secondary)

            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: { Image(systemName: "xmark") }
            }
        }
    }

    // MARK: - Unlocked Content
    private var unlockedContent: some View {
        Form {
            Section(header: Text(settings.language == .english
                                 ? "Parental Controls" : "Ebeveyn Kontrolü")) {
                Toggle(settings.language == .english
                       ? "Enable Parental Controls"
                       : "Ebeveyn Kontrolünü Etkinleştir",
                       isOn: $settings.parentalControlsEnabled)
                    .tint(.orange)
            }

            if settings.parentalControlsEnabled {
                Section(header: Text(settings.language == .english
                                     ? "Restrictions" : "Kısıtlamalar")) {
                    Label(settings.language == .english
                          ? "Premium unlock requires parent PIN"
                          : "Premium kilit açma ebeveyn PIN'i gerektirir",
                          systemImage: "exclamationmark.triangle")
                        .font(.footnote)
                        .foregroundColor(.orange)
                }
            }

            Section {
                Button(role: .destructive) {
                    settings.parentalControlsEnabled = false
                    unlocked = false
                    resetPuzzle()
                } label: {
                    Label(settings.language == .english
                          ? "Lock Settings"
                          : "Ayarları Kilitle",
                          systemImage: "lock.fill")
                }
            }
        }
        .navigationTitle(settings.language == .english
                         ? "Parental Controls" : "Ebeveyn Kontrolü")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: { Image(systemName: "xmark") }
            }
        }
    }

    // MARK: - Logic
    private func checkAnswer() {
        attempts += 1
        if let input = Int(answer.trimmingCharacters(in: .whitespaces)), input == correct {
            withAnimation { unlocked = true }
        } else {
            showError = true
            answer = ""
            if attempts >= 3 { resetPuzzle() }
        }
    }

    private func resetPuzzle() {
        a = Int.random(in: 2...12)
        b = Int.random(in: 2...12)
        answer = ""
        attempts = 0
        showError = false
    }
}
