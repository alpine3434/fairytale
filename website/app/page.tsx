import StarCanvas from "@/components/StarCanvas";
import Navbar from "@/components/Navbar";
import Hero from "@/components/Hero";
import Features from "@/components/Features";
import Categories from "@/components/Categories";
import AppPreview from "@/components/AppPreview";
import Pricing from "@/components/Pricing";
import CTA from "@/components/CTA";
import Footer from "@/components/Footer";

export default function Home() {
  return (
    <>
      <StarCanvas />
      <Navbar />
      <main>
        <Hero />
        <Features />
        <Categories />
        <AppPreview />
        <Pricing />
        <CTA />
      </main>
      <Footer />
    </>
  );
}
