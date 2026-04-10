//
//  ContentView.swift
//  Story App
//
//  Created by Alparslan BIYIK on 10.04.2026.
//

import SwiftUI

struct ContentView: View {
    private var settings = AppSettings.shared
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashView(showSplash: $showSplash)
                    .transition(.opacity)
            } else {
                mainTabView
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: showSplash)
        .preferredColorScheme(settings.isDarkMode ? .dark : nil)
    }

    private var mainTabView: some View {
        TabView {
            BookshelfView()
                .tabItem {
                    Label(settings.language == .english ? "Stories" : "Masallar",
                          systemImage: "books.vertical.fill")
                }

            AchievementsView()
                .tabItem {
                    Label(settings.language == .english ? "Achievements" : "Başarılar",
                          systemImage: "trophy.fill")
                }

            SettingsView()
                .tabItem {
                    Label(settings.language == .english ? "Settings" : "Ayarlar",
                          systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
