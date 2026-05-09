"use client";

import { useEffect, useState } from "react";
import { motion, AnimatePresence } from "framer-motion";

const links = [
  { label: "Özellikler", href: "#ozellikler" },
  { label: "Kategoriler", href: "#kategoriler" },
  { label: "Fiyatlar", href: "#fiyatlar" },
];

export default function Navbar() {
  const [scrolled, setScrolled] = useState(false);
  const [open, setOpen] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 40);
    window.addEventListener("scroll", onScroll);
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  return (
    <motion.header
      initial={{ y: -80, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      transition={{ duration: 0.6, ease: "easeOut" }}
      className="fixed top-0 inset-x-0 z-50"
      style={{
        background: scrolled
          ? "rgba(5,5,16,0.85)"
          : "transparent",
        backdropFilter: scrolled ? "blur(16px)" : "none",
        borderBottom: scrolled
          ? "1px solid rgba(255,215,0,0.1)"
          : "1px solid transparent",
        transition: "all 0.3s ease",
      }}
    >
      <div className="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">
        {/* Logo */}
        <a
          href="#"
          className="flex items-center gap-2 no-underline"
          style={{ textDecoration: "none" }}
        >
          <span style={{ fontSize: "1.5rem" }}>📖</span>
          <span
            className="font-bold text-lg"
            style={{
              background: "linear-gradient(135deg, #FFD700, #FFA500)",
              WebkitBackgroundClip: "text",
              WebkitTextFillColor: "transparent",
              backgroundClip: "text",
            }}
          >
            Masal Hazinesi
          </span>
        </a>

        {/* Desktop links */}
        <nav className="hidden md:flex items-center gap-8">
          {links.map((l) => (
            <a
              key={l.href}
              href={l.href}
              className="text-sm font-medium text-white/70 hover:text-white transition-colors"
              style={{ textDecoration: "none" }}
            >
              {l.label}
            </a>
          ))}
          <a
            href="#indir"
            className="appstore-btn text-sm font-semibold"
            style={{
              padding: "8px 20px",
              color: "#fff",
              textDecoration: "none",
            }}
          >
            <span>🍎</span> İndir
          </a>
        </nav>

        {/* Mobile hamburger */}
        <button
          className="md:hidden flex flex-col gap-1.5 p-2"
          onClick={() => setOpen(!open)}
          aria-label="Menü"
        >
          <span
            style={{
              width: 22,
              height: 2,
              background: "#FFD700",
              borderRadius: 1,
              display: "block",
              transition: "transform 0.3s",
              transform: open ? "rotate(45deg) translate(5px,5px)" : "none",
            }}
          />
          <span
            style={{
              width: 22,
              height: 2,
              background: "#FFD700",
              borderRadius: 1,
              display: "block",
              opacity: open ? 0 : 1,
              transition: "opacity 0.3s",
            }}
          />
          <span
            style={{
              width: 22,
              height: 2,
              background: "#FFD700",
              borderRadius: 1,
              display: "block",
              transition: "transform 0.3s",
              transform: open ? "rotate(-45deg) translate(5px,-5px)" : "none",
            }}
          />
        </button>
      </div>

      {/* Mobile menu */}
      <AnimatePresence>
        {open && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: "auto" }}
            exit={{ opacity: 0, height: 0 }}
            style={{
              background: "rgba(5,5,16,0.97)",
              borderTop: "1px solid rgba(255,215,0,0.1)",
            }}
          >
            <div className="flex flex-col px-6 py-4 gap-4">
              {links.map((l) => (
                <a
                  key={l.href}
                  href={l.href}
                  onClick={() => setOpen(false)}
                  className="text-white/80 py-2 text-base font-medium"
                  style={{ textDecoration: "none" }}
                >
                  {l.label}
                </a>
              ))}
              <a
                href="#indir"
                onClick={() => setOpen(false)}
                className="appstore-btn text-sm font-semibold justify-center"
                style={{ color: "#fff", textDecoration: "none" }}
              >
                <span>🍎</span> App Store'dan İndir
              </a>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </motion.header>
  );
}
