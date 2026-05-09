"use client";

import { motion } from "framer-motion";
import { useInView } from "framer-motion";
import { useRef } from "react";

const features = [
  {
    icon: "📚",
    title: "58 Eşsiz Masal",
    desc: "Peri masalları, fabllar, maceralar, klasikler ve Türk masallarından oluşan geniş bir kütüphane. Her gün yeni bir masal seni bekliyor.",
    color: "#FFD700",
  },
  {
    icon: "🌐",
    title: "İki Dil Desteği",
    desc: "Masalları hem Türkçe hem de İngilizce oku. Dil değiştirmek sadece bir dokunuş uzakta.",
    color: "#4ECDC4",
  },
  {
    icon: "🎙️",
    title: "Sesli Okuma (TTS)",
    desc: "Profesyonel metin-konuşma teknolojisiyle masallar sana okunuyor. Gözlerini dinlendir, kulağınla dinle.",
    color: "#FF6B9D",
  },
  {
    icon: "🏅",
    title: "Başarı Sistemi",
    desc: "Masal okudukça yıldızlar kazan, rozetler topla. Her başarı seni daha fazla okumaya teşvik eder.",
    color: "#FF8C42",
  },
  {
    icon: "❤️",
    title: "Favoriler & İlerleme",
    desc: "Sevdiğin masalları favorilere ekle, kaldığın yerden devam et. Okuma geçmişin her zaman yanında.",
    color: "#FF6B9D",
  },
  {
    icon: "👨‍👩‍👧",
    title: "Ebeveyn Kontrolü",
    desc: "Güvenli içerik, ebeveyn dostu tasarım. Çocuğunuzun deneyimini kolayca yönetin.",
    color: "#9B59B6",
  },
];

function FeatureCard({
  feature,
  index,
}: {
  feature: (typeof features)[0];
  index: number;
}) {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-80px" });

  return (
    <motion.div
      ref={ref}
      initial={{ opacity: 0, y: 50 }}
      animate={inView ? { opacity: 1, y: 0 } : {}}
      transition={{ duration: 0.6, delay: index * 0.08, ease: "easeOut" }}
      className="glass-card p-6"
    >
      <div
        className="w-14 h-14 rounded-2xl flex items-center justify-center text-2xl mb-4"
        style={{
          background: `${feature.color}18`,
          border: `1px solid ${feature.color}30`,
        }}
      >
        {feature.icon}
      </div>
      <h3 className="text-lg font-bold text-white mb-2">{feature.title}</h3>
      <p className="text-sm leading-relaxed" style={{ color: "rgba(255,255,255,0.58)" }}>
        {feature.desc}
      </p>
    </motion.div>
  );
}

export default function Features() {
  const titleRef = useRef(null);
  const titleInView = useInView(titleRef, { once: true, margin: "-80px" });

  return (
    <section id="ozellikler" className="relative z-10 py-24 px-6">
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
            Özellikler
          </span>
          <h2 className="text-3xl md:text-5xl font-black text-white mb-4">
            Masalların{" "}
            <span className="gold-gradient">Büyülü Dünyasına</span>
            <br />
            Hoş Geldiniz
          </h2>
          <p
            className="text-lg max-w-xl mx-auto"
            style={{ color: "rgba(255,255,255,0.5)" }}
          >
            Çocuklarınızın hayal dünyasını zenginleştirecek özelliklerle dolu
            bir uygulama.
          </p>
        </motion.div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {features.map((f, i) => (
            <FeatureCard key={f.title} feature={f} index={i} />
          ))}
        </div>
      </div>
    </section>
  );
}
