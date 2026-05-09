"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";

const categories = [
  {
    emoji: "🧚",
    nametr: "Peri Masalları",
    nameen: "Fairy Tales",
    desc: "Cadılar, prensesler ve sihirli dünyalar...",
    color: "#FF6B9D",
    count: "16 masal",
  },
  {
    emoji: "🦊",
    nametr: "Fabller",
    nameen: "Fables",
    desc: "Kurnaz tilkiler, akıllı kargalar ve dersler...",
    color: "#FF8C42",
    count: "14 masal",
  },
  {
    emoji: "⚔️",
    nametr: "Maceralar",
    nameen: "Adventures",
    desc: "Cesur kahramanlar ve büyük yolculuklar...",
    color: "#4ECDC4",
    count: "10 masal",
  },
  {
    emoji: "📚",
    nametr: "Klasikler",
    nameen: "Classics",
    desc: "Nesiller boyu sevilen zamansız hikâyeler...",
    color: "#9B59B6",
    count: "12 masal",
  },
  {
    emoji: "🌙",
    nametr: "Türk Masalları",
    nameen: "Turkish Tales",
    desc: "Anadolu'nun eşsiz kültür hazineleri...",
    color: "#E74C3C",
    count: "6 masal",
  },
];

export default function Categories() {
  const titleRef = useRef(null);
  const titleInView = useInView(titleRef, { once: true, margin: "-60px" });

  return (
    <section id="kategoriler" className="relative z-10 py-24 px-6">
      {/* Section background glow */}
      <div
        style={{
          position: "absolute",
          inset: 0,
          background:
            "radial-gradient(ellipse at 50% 50%, rgba(255,215,0,0.03) 0%, transparent 70%)",
          pointerEvents: "none",
        }}
      />

      <div className="max-w-6xl mx-auto">
        <motion.div
          ref={titleRef}
          initial={{ opacity: 0, y: 30 }}
          animate={titleInView ? { opacity: 1, y: 0 } : {}}
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
            Kategoriler
          </span>
          <h2 className="text-3xl md:text-5xl font-black text-white mb-4">
            Her Hayal İçin{" "}
            <span className="gold-gradient">Bir Dünya</span>
          </h2>
          <p
            className="text-lg max-w-xl mx-auto"
            style={{ color: "rgba(255,255,255,0.5)" }}
          >
            5 farklı kategoride 58 masal seni bekliyor.
          </p>
        </motion.div>

        {/* Category cards – horizontal scroll on mobile */}
        <div className="flex flex-col md:flex-row gap-4 md:gap-5 overflow-x-auto pb-2 md:overflow-visible">
          {categories.map((cat, i) => (
            <motion.div
              key={cat.nametr}
              initial={{ opacity: 0, y: 40, scale: 0.95 }}
              whileInView={{ opacity: 1, y: 0, scale: 1 }}
              viewport={{ once: true, margin: "-60px" }}
              transition={{ duration: 0.55, delay: i * 0.1 }}
              whileHover={{ y: -8, scale: 1.03 }}
              className="flex-1 min-w-[200px] rounded-2xl p-6 cursor-default"
              style={{
                background: `linear-gradient(145deg, ${cat.color}18, ${cat.color}08)`,
                border: `1px solid ${cat.color}30`,
                transition: "box-shadow 0.3s ease",
              }}
              onMouseEnter={(e) => {
                (e.currentTarget as HTMLElement).style.boxShadow = `0 20px 60px ${cat.color}20`;
              }}
              onMouseLeave={(e) => {
                (e.currentTarget as HTMLElement).style.boxShadow = "none";
              }}
            >
              {/* Emoji circle */}
              <div
                className="w-16 h-16 rounded-full flex items-center justify-center text-3xl mb-4"
                style={{
                  background: `${cat.color}22`,
                  border: `2px solid ${cat.color}40`,
                }}
              >
                {cat.emoji}
              </div>

              <h3 className="text-lg font-bold text-white mb-1">
                {cat.nametr}
              </h3>
              <p
                className="text-xs mb-1 font-medium"
                style={{ color: cat.color }}
              >
                {cat.nameen}
              </p>
              <p
                className="text-sm mt-2 leading-relaxed"
                style={{ color: "rgba(255,255,255,0.5)" }}
              >
                {cat.desc}
              </p>
              <div
                className="mt-4 text-xs font-semibold px-3 py-1 rounded-full inline-block"
                style={{
                  background: `${cat.color}20`,
                  color: cat.color,
                  border: `1px solid ${cat.color}35`,
                }}
              >
                {cat.count}
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
