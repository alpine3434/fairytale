import type { Metadata, Viewport } from "next";
import "./globals.css";

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: "#050510",
};

export const metadata: Metadata = {
  title: "Büyük Masal Hazinesi – 58 Çocuk Masalı | iOS Uygulama",
  description:
    "Büyük Masal Hazinesi: Peri masalları, Fabllar, Türk masalları ve daha fazlası. Türkçe ve İngilizce 58 masalı keşfet. Çocuklarınız için en iyi masal uygulaması.",
  keywords: [
    "masal uygulaması",
    "çocuk masalları",
    "peri masalları",
    "türk masalları",
    "fabller",
    "iOS masal uygulaması",
    "children stories app",
    "fairy tales",
    "masal hazinesi",
    "büyük masal hazinesi",
  ],
  authors: [{ name: "Masal Hazinesi" }],
  creator: "Masal Hazinesi",
  publisher: "Masal Hazinesi",
  openGraph: {
    title: "Büyük Masal Hazinesi – 58 Masalın Büyülü Dünyası",
    description:
      "Peri masalları, fabllar, maceralar ve Türk masallarıyla dolu 58 masalı keşfet. Türkçe ve İngilizce.",
    type: "website",
    locale: "tr_TR",
    siteName: "Büyük Masal Hazinesi",
  },
  twitter: {
    card: "summary_large_image",
    title: "Büyük Masal Hazinesi – 58 Masalın Büyülü Dünyası",
    description:
      "Çocuklarınız için en iyi masal uygulaması. 58 masal, Türkçe & İngilizce.",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
};

const jsonLd = {
  "@context": "https://schema.org",
  "@type": "MobileApplication",
  name: "Büyük Masal Hazinesi",
  description:
    "58 masal içeren çocuk uygulaması. Peri masalları, fabllar, Türk masalları, maceralar ve klasikler. Türkçe ve İngilizce.",
  applicationCategory: "EducationalApplication",
  operatingSystem: "iOS",
  offers: {
    "@type": "Offer",
    price: "0",
    priceCurrency: "TRY",
  },
  audience: {
    "@type": "Audience",
    audienceType: "Children",
  },
  inLanguage: ["tr", "en"],
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="tr" className="h-full">
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      </head>
      <body className="min-h-full antialiased">{children}</body>
    </html>
  );
}
