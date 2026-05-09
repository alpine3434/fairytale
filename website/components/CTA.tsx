"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";

export default function CTA() {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-60px" });

  return (
    <section className="relative z-10 py-24 px-6" id="indir-section">
      <div className="max-w-3xl mx-auto">
        <motion.div
          ref={ref}
          initial={{ opacity: 0, y: 40 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.8 }}
          className="relative overflow-hidden rounded-3xl text-center py-16 px-8"
          style={{
            background:
              "linear-gradient(145deg, rgba(255,215,0,0.08) 0%, rgba(255,165,0,0.04) 50%, rgba(15,52,96,0.4) 100%)",
            border: "1px solid rgba(255,215,0,0.2)",
          }}
        >
          {/* Background decoration */}
          <div
            style={{
              position: "absolute",
              top: -60,
              right: -60,
              width: 200,
              height: 200,
              borderRadius: "50%",
              background:
                "radial-gradient(circle, rgba(255,215,0,0.12) 0%, transparent 70%)",
              pointerEvents: "none",
            }}
          />
          <div
            style={{
              position: "absolute",
              bottom: -40,
              left: -40,
              width: 160,
              height: 160,
              borderRadius: "50%",
              background:
                "radial-gradient(circle, rgba(78,205,196,0.08) 0%, transparent 70%)",
              pointerEvents: "none",
            }}
          />

          <div className="relative z-10">
            <motion.div
              initial={{ scale: 0 }}
              animate={inView ? { scale: 1 } : {}}
              transition={{ duration: 0.6, delay: 0.2, type: "spring" }}
              className="text-6xl mb-6"
            >
              📖
            </motion.div>

            <h2 className="text-3xl md:text-5xl font-black text-white mb-4">
              Masallar Seni{" "}
              <span className="gold-gradient">Bekliyor!</span>
            </h2>

            <p
              className="text-lg mb-10 max-w-xl mx-auto"
              style={{ color: "rgba(255,255,255,0.55)" }}
            >
              Ücretsiz indir, bugün masallar dünyasına adım at. 58 masal, sonsuz
              hayal gücü.
            </p>

            <motion.a
              href="#"
              className="appstore-btn inline-flex mx-auto"
              whileHover={{ scale: 1.06 }}
              whileTap={{ scale: 0.97 }}
              style={{ textDecoration: "none" }}
            >
              <svg width="32" height="32" viewBox="0 0 24 24" fill="white">
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
            </motion.a>

            <p
              className="mt-6 text-xs"
              style={{ color: "rgba(255,255,255,0.3)" }}
            >
              iOS 15.0 ve üzeri · Türkçe & English
            </p>
          </div>
        </motion.div>
      </div>
    </section>
  );
}
