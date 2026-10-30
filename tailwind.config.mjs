/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        shelter: {
          50: '#f4f9f4',
          100: '#e5f3e5',
          200: '#cce6cc',
          300: '#a3d1a3',
          400: '#73b673',
          500: '#4e9a4e',
          600: '#3c7e3c',
          700: '#316431',
          800: '#2a502a',
          900: '#244324',
          950: '#0f240f',
        },
        warm: {
          50: '#fdfbf7',
          100: '#f9f4eb',
          200: '#f3e8d4',
          300: '#e9d4b3',
          400: '#dcba8c',
          500: '#cf9e6a',
          600: '#c18653',
          700: '#a06a44',
          800: '#82563c',
          900: '#6a4734',
        }
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'sans-serif'],
      }
    },
  },
  plugins: [],
};
