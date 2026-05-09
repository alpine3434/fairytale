"use client";

import { motion } from "framer-motion";

import type { Variants } from "framer-motion";

const fadeUp = (delay = 0): Variants => ({
  hidden: { opacity: 0, y: 40 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.7, delay, ease: "easeOut" as const } },
});

export default function Hero() {
  return (
    <section
      id="hero"
      className="relative min-h-screen flex flex-col items-center justify-center text-center px-6 pt-20 pb-16 overflow-hidden"
    >
      {/* Radial glow behind content */}
      <div
        style={{
          position: "absolute",
          top: "40%",
          left: "50%",
          transform: "translate(-50%, -50%)",
          width: 700,
          height: 700,
          borderRadius: "50%",
          background:
            "radial-gradient(circle, rgba(255,215,0,0.07) 0%, transparent 70%)",
          pointerEvents: "none",
          zIndex: 1,
        }}
      />

      <motion.div
        className="relative z-10 max-w-4xl mx-auto"
        initial="hidden"
        animate="visible"
        variants={{ visible: { transition: { staggerChildren: 0.15 } } }}
      >
        {/* Badge */}
        <motion.div variants={fadeUp(0)} className="mb-6 inline-flex">
          <span
            className="text-xs font-semibold tracking-widest uppercase px-4 py-1.5 rounded-full"
            style={{
              background: "rgba(255,215,0,0.12)",
              border: "1px solid rgba(255,215,0,0.3)",
              color: "#FFD700",
            }}
          >
            🌟 Çocuklar için en iyi masal uygulaması
          </span>
        </motion.div>

        {/* Main title */}
        <motion.h1
          variants={fadeUp(0.1)}
          className="text-5xl md:text-7xl font-black leading-tight mb-2"
        >
          <span className="block text-white">BÜYÜK</span>
          <span className="block gold-gradient text-6xl md:text-8xl">
            Masal Hazinesi
          </span>
        </motion.h1>

        {/* Subtitle */}
        <motion.p
          variants={fadeUp(0.2)}
          className="mt-6 text-lg md:text-xl font-light max-w-2xl mx-auto"
          style={{ color: "rgba(255,255,255,0.65)", lineHeight: 1.7 }}
        >
          58 muhteşem masal — peri masalları, fabllar, maceralar, klasikler ve
          Türk masalları. Hem{" "}
          <span style={{ color: "#FFD700", fontWeight: 600 }}>Türkçe</span> hem
          de{" "}
          <span style={{ color: "#FFD700", fontWeight: 600 }}>İngilizce</span>{" "}
          oku, sevdiklerini keşfet!
        </motion.p>

        {/* Stats */}
        <motion.div
          variants={fadeUp(0.3)}
          className="mt-10 flex flex-wrap justify-center gap-8"
        >
          {[
            { value: "58", label: "Masal" },
            { value: "5", label: "Kategori" },
            { value: "2", label: "Dil" },
            { value: "∞", label: "Eğlence" },
          ].map((s) => (
            <div key={s.label} className="text-center">
              <div
                className="text-3xl md:text-4xl font-black"
                style={{ color: "#FFD700" }}
              >
                {s.value}
              </div>
              <div className="text-sm mt-1" style={{ color: "rgba(255,255,255,0.5)" }}>
                {s.label}
              </div>
            </div>
          ))}
        </motion.div>

        {/* CTA Buttons */}
        <motion.div
          variants={fadeUp(0.4)}
          className="mt-10 flex flex-wrap justify-center gap-4"
          id="indir"
        >
          <a
            href="#"
            className="appstore-btn pulse-gold"
            style={{ textDecoration: "none" }}
          >
            <svg width="28" height="28" viewBox="0 0 24 24" fill="white">
              <path d="M18.71 19.5C17.88 20.74 17 21.95 15.66 21.97C14.32 22 13.89 21.18 12.37 21.18C10.84 21.18 10.37 21.95 9.1 22C7.78 22.05 6.8 20.68 5.96 19.47C4.25 17 2.94 12.45 4.7 9.39C5.57 7.87 7.13 6.91 8.82 6.88C10.1 6.86 11.32 7.75 12.11 7.75C12.89 7.75 14.37 6.68 15.92 6.84C16.57 6.87 18.39 7.1 19.56 8.82C19.47 8.88 17.39 10.1 17.41 12.63C17.44 15.65 20.06 16.66 20.09 16.67C20.06 16.74 19.67 18.11 18.71 19.5ZM13 3.5C13.73 2.67 14.94 2.04 15.94 2C16.07 3.17 15.6 4.35 14.9 5.19C14.21 6.04 13.07 6.7 11.95 6.61C11.8 5.46 12.36 4.26 13 3.5Z" />
            </svg>
            <div className="text-left">
              <div className="text-xs" style={{ color: "rgba(255,255,255,0.6)" }}>
                App Store'dan İndir
              </div>
              <div className="text-base font-bold text-white">
                Ücretsiz Başla
              </div>
            </div>
          </a>
        </motion.div>

        {/* Language flags */}
        <motion.div
          variants={fadeUp(0.5)}
          className="mt-8 flex items-center justify-center gap-3 text-sm"
          style={{ color: "rgba(255,255,255,0.4)" }}
        >
          <span>🇹🇷 Türkçe</span>
          <span>·</span>
          <span>🇬🇧 English</span>
          <span>·</span>
          <span>iOS</span>
        </motion.div>
      </motion.div>

      {/* Floating book emoji decoration */}
      <div
        className="float-anim"
        style={{
          position: "absolute",
          bottom: 60,
          right: "8%",
          fontSize: "5rem",
          opacity: 0.12,
          zIndex: 1,
          userSelect: "none",
        }}
      >
        📚
      </div>
      <div
        style={{
          position: "absolute",
          top: "20%",
          left: "5%",
          fontSize: "3rem",
          opacity: 0.1,
          zIndex: 1,
          userSelect: "none",
          animation: "float 6s ease-in-out infinite 1s",
        }}
      >
        🌙
      </div>

      {/* Bottom fade */}
      <div
        style={{
          position: "absolute",
          bottom: 0,
          left: 0,
          right: 0,
          height: 120,
          background:
            "linear-gradient(transparent, #050510)",
          zIndex: 2,
        }}
      />
    </section>
  );
}
