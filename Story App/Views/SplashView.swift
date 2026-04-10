import SwiftUI

struct SplashView: View {
    @Binding var showSplash: Bool
    @State private var opacity: Double = 0
    @State private var scale: CGFloat = 0.85
    @State private var titleOffset: CGFloat = 40

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color(hex: "1a1a2e"), Color(hex: "16213e"), Color(hex: "0f3460")],
                startPoint: .top, endPoint: .bottom
            ).ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Book cover image
                Image("masalhazinesi")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.6), radius: 30, x: 0, y: 15)
                    .scaleEffect(scale)
                    .opacity(opacity)

                Spacer().frame(height: 32)

                // Title
                VStack(spacing: 8) {
                    Text("BÜYÜK")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.yellow.opacity(0.9))
                        .kerning(6)
                    Text("Masal Hazinesi")
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .yellow.opacity(0.4), radius: 10)
                    Text("58 Muhteşem Masal")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.65))
                        .padding(.top, 4)
                }
                .offset(y: titleOffset)
                .opacity(opacity)

                Spacer().frame(height: 50)

                // Start button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showSplash = false
                    }
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "books.vertical.fill")
                        Text("Masallara Başla")
                            .fontWeight(.semibold)
                    }
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(Color(hex: "1a1a2e"))
                    .padding(.horizontal, 36)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(colors: [.yellow, Color(hex: "FFD700")],
                                       startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(Capsule())
                    .shadow(color: .yellow.opacity(0.5), radius: 12, x: 0, y: 6)
                }
                .opacity(opacity)

                Spacer().frame(height: 20)

                // Language flags
                HStack(spacing: 16) {
                    Text("🇹🇷 Türkçe")
                    Text("·")
                    Text("🇬🇧 English")
                }
                .font(.caption)
                .foregroundColor(.white.opacity(0.4))
                .opacity(opacity)

                Spacer()
            }
            .padding(.horizontal)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.9)) {
                opacity = 1
                scale = 1
                titleOffset = 0
            }
        }
    }
}
