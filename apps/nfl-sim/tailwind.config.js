/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
    '../../packages/shared-ui/src/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        // Light mode with dark accents
        background: {
          DEFAULT: '#FFFFFF',
          secondary: '#F8F9FA',
          tertiary: '#F1F3F5',
        },
        accent: {
          DEFAULT: '#212529',
          secondary: '#343A40',
          tertiary: '#495057',
        },
        nfl: {
          blue: '#013369',
          red: '#D50A0A',
        },
      },
      fontFamily: {
        sans: ['system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
