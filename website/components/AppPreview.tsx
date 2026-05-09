"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";

type ContentItem =
  | { type: "hero"; text: string; sub: string }
  | { type: "btn"; text: string }
  | { type: "flags"; text: string }
  | { type: "categories"; items: string[] }
  | { type: "books"; items: string[] }
  | { type: "stars"; count: number }
  | { type: "badges"; items: string[] };

interface MockScreen {
  title: string;
  emoji: string;
  bg: string;
  content: ContentItem[];
}

const mockScreens: MockScreen[] = [
  {
    title: "Ana Sayfa",
    emoji: "🏠",
    bg: "linear-gradient(145deg, #1a1a2e, #0f3460)",
    content: [
      { type: "hero", text: "BÜYÜK Masal Hazinesi", sub: "58 Muhteşem Masal" },
      { type: "btn", text: "Masallara Başla →" },
      { type: "flags", text: "🇹🇷 Türkçe · 🇬🇧 English" },
    ],
  },
  {
    title: "Kütüphane",
    emoji: "📚",
    bg: "linear-gradient(145deg, #0a0a1a, #16213e)",
    content: [
      { type: "categories", items: ["🧚 Peri", "🦊 Fabl", "⚔️ Macera"] },
      { type: "books", items: ["Kırmızı Başlıklı Kız", "Pinokyo", "Külkedisi"] },
    ],
  },
  {
    title: "Başarılar",
    emoji: "🏅",
    bg: "linear-gradient(145deg, #0a0a1a, #1a1a2e)",
    content: [
      { type: "stars", count: 42 },
      { type: "badges", items: ["📖 İlk Okuma", "⭐ 10 Yıldız", "❤️ Favori"] },
    ],
  },
];

function PhoneMockup({
  screen,
  index,
  offset = 0,
}: {
  screen: MockScreen;
  index: number;
  offset?: number;
}) {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-60px" });

  return (
    <motion.div
      ref={ref}
      initial={{ opacity: 0, y: 60, rotate: offset * 0.5 }}
      animate={inView ? { opacity: 1, y: 0, rotate: offset * 4 } : {}}
      transition={{ duration: 0.8, delay: index * 0.15, ease: "easeOut" }}
      whileHover={{ y: -12, rotate: 0, scale: 1.03 }}
      className="float-anim"
      style={{
        animationDelay: `${index * 1.2}s`,
        position: "relative",
        zIndex: 3 - index,
      }}
    >
      {/* Phone frame */}
      <div
        style={{
          width: 200,
          height: 380,
          borderRadius: 32,
          background: "#111",
          border: "2px solid rgba(255,215,0,0.25)",
          boxShadow: "0 30px 80px rgba(0,0,0,0.8), 0 0 0 1px rgba(255,255,255,0.04)",
          overflow: "hidden",
          position: "relative",
        }}
      >
        {/* Notch */}
        <div
          style={{
            position: "absolute",
            top: 10,
            left: "50%",
            transform: "translateX(-50%)",
            width: 60,
            height: 6,
            background: "#222",
            borderRadius: 4,
            zIndex: 10,
          }}
        />

        {/* Screen content */}
        <div
          style={{
            background: screen.bg,
            width: "100%",
            height: "100%",
            padding: "28px 12px 12px",
            display: "flex",
            flexDirection: "column",
            gap: 10,
          }}
        >
          {screen.content.map((item, i) => {
            if (item.type === "hero") {
              return (
                <div key={i} className="text-center mt-4">
                  <div
                    style={{
                      fontSize: 9,
                      color: "rgba(255,215,0,0.7)",
                      letterSpacing: 2,
                      marginBottom: 4,
                    }}
                  >
                    BÜYÜK
                  </div>
                  <div
                    style={{
                      fontSize: 14,
                      fontWeight: 800,
                      color: "#fff",
                      lineHeight: 1.2,
                    }}
                  >
                    Masal Hazinesi
                  </div>
                  <div style={{ fontSize: 9, color: "rgba(255,255,255,0.5)", marginTop: 4 }}>
                    {item.sub}
                  </div>
                </div>
              );
            }
            if (item.type === "btn") {
              return (
                <div key={i} className="flex justify-center mt-2">
                  <div
                    style={{
                      background: "linear-gradient(90deg, #FFD700, #FFA500)",
                      borderRadius: 20,
                      padding: "5px 16px",
                      fontSize: 10,
                      fontWeight: 700,
                      color: "#1a1a2e",
                    }}
                  >
                    {item.text}
                  </div>
                </div>
              );
            }
            if (item.type === "flags") {
              return (
                <div
                  key={i}
                  className="text-center"
                  style={{ fontSize: 8, color: "rgba(255,255,255,0.35)", marginTop: 4 }}
                >
                  {item.text}
                </div>
              );
            }
            if (item.type === "categories" && item.items) {
              return (
                <div key={i} className="flex gap-1 mt-2 justify-center flex-wrap">
                  {item.items.map((cat) => (
                    <span
                      key={cat}
                      style={{
                        background: "rgba(255,215,0,0.12)",
                        border: "1px solid rgba(255,215,0,0.2)",
                        borderRadius: 20,
                        padding: "2px 8px",
                        fontSize: 8,
                        color: "#FFD700",
                      }}
                    >
                      {cat}
                    </span>
                  ))}
                </div>
              );
            }
            if (item.type === "books" && item.items) {
              return (
                <div key={i} className="flex flex-col gap-1.5 mt-2">
                  {item.items.map((book) => (
                    <div
                      key={book}
                      style={{
                        background: "rgba(255,255,255,0.06)",
                        borderRadius: 8,
                        padding: "5px 8px",
                        fontSize: 9,
                        color: "rgba(255,255,255,0.7)",
                        border: "1px solid rgba(255,255,255,0.08)",
                      }}
                    >
                      📖 {book}
                    </div>
                  ))}
                </div>
              );
            }
            if (item.type === "stars") {
              return (
                <div key={i} className="text-center mt-4">
                  <div
                    style={{
                      width: 60,
                      height: 60,
                      borderRadius: "50%",
                      background: "linear-gradient(145deg, #FFD700, #FFA500)",
                      display: "flex",
                      flexDirection: "column",
                      alignItems: "center",
                      justifyContent: "center",
                      margin: "0 auto",
                      boxShadow: "0 8px 24px rgba(255,215,0,0.4)",
                    }}
                  >
                    <span style={{ fontSize: 18 }}>⭐</span>
                    <span style={{ fontSize: 11, fontWeight: 800, color: "#1a1a2e" }}>
                      {item.count}
                    </span>
                  </div>
                </div>
              );
            }
            if (item.type === "badges" && item.items) {
              return (
                <div key={i} className="flex flex-col gap-1.5 mt-3">
                  {item.items.map((badge) => (
                    <div
                      key={badge}
                      style={{
                        background: "rgba(255,215,0,0.08)",
                        border: "1px solid rgba(255,215,0,0.2)",
                        borderRadius: 8,
                        padding: "4px 8px",
                        fontSize: 9,
                        color: "#FFD700",
                      }}
                    >
                      {badge}
                    </div>
                  ))}
                </div>
              );
            }
            return null;
          })}
        </div>
      </div>

      {/* Label below phone */}
      <div className="text-center mt-3">
        <span
          style={{
            fontSize: 12,
            color: "rgba(255,255,255,0.45)",
            fontWeight: 500,
          }}
        >
          {screen.emoji} {screen.title}
        </span>
      </div>
    </motion.div>
  );
}

export default function AppPreview() {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-60px" });

  return (
    <section className="relative z-10 py-24 px-6 overflow-hidden">
      <div
        style={{
          position: "absolute",
          inset: 0,
          background:
            "radial-gradient(ellipse at 50% 60%, rgba(15,52,96,0.4) 0%, transparent 70%)",
          pointerEvents: "none",
        }}
      />

      <div className="max-w-6xl mx-auto">
        <motion.div
          ref={ref}
          initial={{ opacity: 0, y: 30 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.7 }}
          className="text-center mb-16"
        >
          <span
            className="text-xs font-semibold tracking-widest uppercase px-4 py-1.5 rounded-full inline-block mb-4"
            style={{
              background: "rgba(255,215,0,0.1)",
              border: "1px solid rgba(255,215,0,0.25)",
              color: "#FFD700",
            }}
          >
            Uygulama İçi Görünüm
          </span>
          <h2 className="text-3xl md:text-5xl font-black text-white mb-4">
            Her Ekranda{" "}
            <span className="gold-gradient">Sihirli Bir Deneyim</span>
          </h2>
          <p
            className="text-lg max-w-xl mx-auto"
            style={{ color: "rgba(255,255,255,0.5)" }}
          >
            Modern, zarif ve çocuk dostu arayüzüyle masallar bir dokunuşta
            hayat buluyor.
          </p>
        </motion.div>

        <div className="flex justify-center items-end gap-6 flex-wrap md:flex-nowrap">
          {mockScreens.map((screen, i) => (
            <PhoneMockup
              key={screen.title}
              screen={screen}
              index={i}
              offset={i === 0 ? -1 : i === 2 ? 1 : 0}
            />
          ))}
        </div>
      </div>
    </section>
  );
}
