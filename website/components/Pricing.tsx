"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";

const freeTier = {
  name: "Ücretsiz",
  price: "₺0",
  color: "#4ECDC4",
  features: [
    { text: "Seçili ücretsiz masallar", ok: true },
    { text: "Türkçe ve İngilizce", ok: true },
    { text: "Temel başarılar", ok: true },
    { text: "Favoriler listesi", ok: true },
    { text: "Tüm 58 masal", ok: false },
    { text: "Sesli okuma (TTS)", ok: false },
    { text: "Reklamsız deneyim", ok: false },
  ],
};

const premiumTier = {
  name: "Premium",
  price: "Tek Seferlik",
  color: "#FFD700",
  badge: "En Popüler",
  features: [
    { text: "Tüm 58 masal – sınırsız", ok: true },
    { text: "Türkçe ve İngilizce", ok: true },
    { text: "Tüm başarılar & rozetler", ok: true },
    { text: "Favoriler listesi", ok: true },
    { text: "Sesli okuma (TTS)", ok: true },
    { text: "Reklamsız deneyim", ok: true },
    { text: "Ömür boyu güncelleme", ok: true },
  ],
};

function Check({ ok, color }: { ok: boolean; color: string }) {
  return (
    <span
      style={{
        width: 20,
        height: 20,
        borderRadius: "50%",
        display: "inline-flex",
        alignItems: "center",
        justifyContent: "center",
        background: ok ? `${color}20` : "rgba(255,255,255,0.06)",
        flexShrink: 0,
        fontSize: 11,
      }}
    >
      {ok ? (
        <span style={{ color }}> ✓</span>
      ) : (
        <span style={{ color: "rgba(255,255,255,0.25)" }}>✕</span>
      )}
    </span>
  );
}

export default function Pricing() {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-60px" });

  return (
    <section id="fiyatlar" className="relative z-10 py-24 px-6">
      <div className="max-w-4xl mx-auto">
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
            Fiyatlandırma
          </span>
          <h2 className="text-3xl md:text-5xl font-black text-white mb-4">
            Başla, Seviyorsan{" "}
            <span className="gold-gradient">Tam Sürüme Geç</span>
          </h2>
          <p
            className="text-lg max-w-xl mx-auto"
            style={{ color: "rgba(255,255,255,0.5)" }}
          >
            Ücretsiz başla, istediğin zaman tüm masallara eriş.
          </p>
        </motion.div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {/* Free */}
          <motion.div
            initial={{ opacity: 0, x: -40 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.65 }}
            className="glass-card p-8"
          >
            <div
              className="text-sm font-semibold mb-1"
              style={{ color: freeTier.color }}
            >
              {freeTier.name}
            </div>
            <div className="text-4xl font-black text-white mb-6">
              {freeTier.price}
            </div>
            <div className="flex flex-col gap-3 mb-8">
              {freeTier.features.map((f) => (
                <div key={f.text} className="flex items-center gap-3">
                  <Check ok={f.ok} color={freeTier.color} />
                  <span
                    className="text-sm"
                    style={{
                      color: f.ok
                        ? "rgba(255,255,255,0.8)"
                        : "rgba(255,255,255,0.28)",
                    }}
                  >
                    {f.text}
                  </span>
                </div>
              ))}
            </div>
            <a
              href="#indir"
              className="block text-center w-full py-3 rounded-xl font-semibold text-sm transition-all"
              style={{
                background: "rgba(255,255,255,0.07)",
                border: "1px solid rgba(255,255,255,0.15)",
                color: "#fff",
                textDecoration: "none",
              }}
            >
              Ücretsiz İndir
            </a>
          </motion.div>

          {/* Premium */}
          <motion.div
            initial={{ opacity: 0, x: 40 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.65, delay: 0.1 }}
            style={{
              position: "relative",
              background: "linear-gradient(145deg, rgba(255,215,0,0.08), rgba(255,165,0,0.04))",
              border: "1px solid rgba(255,215,0,0.35)",
              borderRadius: "1.25rem",
              padding: "2rem",
              boxShadow: "0 0 60px rgba(255,215,0,0.08)",
            }}
          >
            {/* Badge */}
            <div
              style={{
                position: "absolute",
                top: -12,
                left: "50%",
                transform: "translateX(-50%)",
                background: "linear-gradient(90deg, #FFD700, #FFA500)",
                borderRadius: 20,
                padding: "3px 14px",
                fontSize: 11,
                fontWeight: 700,
                color: "#1a1a2e",
                whiteSpace: "nowrap",
              }}
            >
              ⭐ {premiumTier.badge}
            </div>

            <div
              className="text-sm font-semibold mb-1"
              style={{ color: premiumTier.color }}
            >
              {premiumTier.name}
            </div>
            <div className="text-4xl font-black text-white mb-1">
              {premiumTier.price}
            </div>
            <div
              className="text-xs mb-6"
              style={{ color: "rgba(255,255,255,0.4)" }}
            >
              Bir kez öde, sonsuza kadar kullan
            </div>
            <div className="flex flex-col gap-3 mb-8">
              {premiumTier.features.map((f) => (
                <div key={f.text} className="flex items-center gap-3">
                  <Check ok={f.ok} color={premiumTier.color} />
                  <span
                    className="text-sm"
                    style={{
                      color: f.ok
                        ? "rgba(255,255,255,0.85)"
                        : "rgba(255,255,255,0.28)",
                    }}
                  >
                    {f.text}
                  </span>
                </div>
              ))}
            </div>
            <a
              href="#indir"
              className="block text-center w-full py-3 rounded-xl font-bold text-sm transition-all pulse-gold"
              style={{
                background: "linear-gradient(90deg, #FFD700, #FFA500)",
                color: "#1a1a2e",
                textDecoration: "none",
              }}
            >
              Tam Sürümü Al
            </a>
          </motion.div>
        </div>
      </div>
    </section>
  );
}
