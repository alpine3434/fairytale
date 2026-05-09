import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "export",
  basePath: "/fairytale",
  trailingSlash: true,
  images: {
    unoptimized: true,
  },
};

export default nextConfig;
