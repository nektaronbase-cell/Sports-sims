/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  transpilePackages: ['@sports-sims/shared-ui', '@sports-sims/shared-utils', '@sports-sims/database'],
  images: {
    domains: ['localhost'],
  },
}

module.exports = nextConfig
