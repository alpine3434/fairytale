import SwiftUI

struct SettingsView: View {
    @Bindable private var settings = AppSettings.shared
    @Bindable private var purchases = PurchaseManager.shared
    @State private var showParentalControl = false

    var body: some View {
        NavigationStack {
            Form {
                // Language
                Section(header: Text(settings.language == .english ? "Language" : "Dil")) {
                    languagePicker(
                        title: settings.language == .english ? "Story Language" : "Masal Dili",
                        selection: $settings.language
                    )
                    languagePicker(
                        title: settings.language == .english ? "Subtitle Language" : "Altyazı Dili",
                        selection: $settings.subtitleLanguage
                    )
                    Toggle(settings.language == .english ? "Show Subtitle" : "Altyazı Göster",
                           isOn: $settings.showSubtitle)
                        .tint(.blue)
                }

                // Reading
                Section(header: Text(settings.language == .english ? "Reading" : "Okuma")) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(settings.language == .english ? "Text Size" : "Yazı Boyutu")
                            Spacer()
                            Text("\(Int(settings.fontSize)) pt")
                                .foregroundColor(.secondary)
                        }
                        Slider(value: $settings.fontSize, in: 14...28, step: 1)
                            .tint(.blue)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(settings.language == .english ? "Reading Speed" : "Okuma Hızı")
                            Spacer()
                            speedLabel
                        }
                        HStack {
                            Image(systemName: "tortoise.fill").foregroundColor(.secondary)
                            Slider(value: $settings.readingSpeed, in: 0.2...0.6, step: 0.05)
                                .tint(.blue)
                            Image(systemName: "hare.fill").foregroundColor(.secondary)
                        }
                    }
                }

                // Appearance
                Section(header: Text(settings.language == .english ? "Appearance" : "Görünüm")) {
                    Toggle(settings.language == .english ? "Dark Mode" : "Karanlık Mod",
                           isOn: $settings.isDarkMode)
                        .tint(.blue)
                }

                // Premium
                Section(header: Text(settings.language == .english ? "Premium" : "Premium")) {
                    if purchases.isPremium {
                        HStack {
                            Image(systemName: "checkmark.seal.fill").foregroundColor(.yellow)
                            Text(settings.language == .english ? "Premium Active" : "Premium Aktif")
                        }
                    } else {
                        Button {
                            purchases.purchasePremium()
                        } label: {
                            Label(settings.language == .english ? "Unlock All 58 Stories" : "58 Masalın Hepsini Aç",
                                  systemImage: "star.fill")
                                .foregroundColor(.orange)
                        }
                        Button {
                            purchases.restorePurchases()
                        } label: {
                            Label(settings.language == .english ? "Restore Purchases" : "Satın Alımları Geri Yükle",
                                  systemImage: "arrow.clockwise")
                                .foregroundColor(.secondary)
                        }
                    }
                }

                // Parental Controls
                Section(header: Text(settings.language == .english ? "Parental" : "Ebeveyn")) {
                    Button {
                        showParentalControl = true
                    } label: {
                        Label(settings.language == .english
                              ? "Parental Controls"
                              : "Ebeveyn Kontrolü",
                              systemImage: "lock.shield")
                            .foregroundColor(.orange)
                    }
                }

                // About
                Section(header: Text(settings.language == .english ? "About" : "Hakkında")) {
                    HStack {
                        Text(settings.language == .english ? "Version" : "Sürüm")
                        Spacer()
                        Text("1.0.0").foregroundColor(.secondary)
                    }
                    HStack {
                        Text(settings.language == .english ? "Stories" : "Masal Sayısı")
                        Spacer()
                        Text("58").foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle(settings.language == .english ? "Settings" : "Ayarlar")
            .sheet(isPresented: $showParentalControl) {
                ParentalControlView()
            }
        }
        .preferredColorScheme(settings.isDarkMode ? .dark : nil)
    }

    private var speedLabel: some View {
        let speed = settings.readingSpeed
        let label: String
        if settings.language == .english {
            label = speed < 0.3 ? "Slow" : speed < 0.45 ? "Normal" : "Fast"
        } else {
            label = speed < 0.3 ? "Yavaş" : speed < 0.45 ? "Normal" : "Hızlı"
        }
        return Text(label).foregroundColor(.secondary)
    }

    private func languagePicker(title: String, selection: Binding<AppLanguage>) -> some View {
        Picker(title, selection: selection) {
            ForEach(AppLanguage.allCases, id: \.self) { lang in
                Text("\(lang.flag) \(lang.displayName)").tag(lang)
            }
        }
    }
}
