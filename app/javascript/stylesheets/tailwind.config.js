const colors = require('tailwindcss/colors')

module.exports = {
  purge: [
    "./app/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/javascript/**/*.vue",
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        sky: colors.sky,
      },
      spacing: {
        '120': '30rem',
        '160': '40rem',
        '200': '50rem',
        '2000': '2000px'
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
