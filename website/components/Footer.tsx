"use client";

export default function Footer() {
  const year = new Date().getFullYear();

  return (
    <footer
      className="relative z-10 py-12 px-6"
      style={{ borderTop: "1px solid rgba(255,215,0,0.08)" }}
    >
      <div className="max-w-6xl mx-auto">
        <div className="flex flex-col md:flex-row items-center justify-between gap-6">
          {/* Brand */}
          <div className="flex items-center gap-2">
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
              Büyük Masal Hazinesi
            </span>
          </div>

          {/* Links */}
          <div className="flex flex-wrap justify-center gap-6">
            {[
              { label: "Gizlilik Politikası", href: "#" },
              { label: "Kullanım Şartları", href: "#" },
              { label: "İletişim", href: "#" },
            ].map((l) => (
              <a
                key={l.label}
                href={l.href}
                className="text-sm"
                style={{
                  color: "rgba(255,255,255,0.4)",
                  textDecoration: "none",
                  transition: "color 0.2s",
                }}
                onMouseEnter={(e) =>
                  ((e.target as HTMLElement).style.color = "rgba(255,215,0,0.8)")
                }
                onMouseLeave={(e) =>
                  ((e.target as HTMLElement).style.color = "rgba(255,255,255,0.4)")
                }
              >
                {l.label}
              </a>
            ))}
          </div>

          {/* Copyright */}
          <p className="text-xs" style={{ color: "rgba(255,255,255,0.25)" }}>
            © {year} Masal Hazinesi. Tüm hakları saklıdır.
          </p>
        </div>
      </div>
    </footer>
  );
}
