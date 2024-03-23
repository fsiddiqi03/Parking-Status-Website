/** @type {import('tailwindcss').Config} */
const {nextui} = require("@nextui-org/react");


module.exports = {
  content: [
    // ...
    "./node_modules/@nextui-org/theme/dist/**/*.{js,ts,jsx,tsx}",
    "./src/**/*.{html,js}"
  ],
  theme: {
    extend: {},
  },
  darkMode: "class",
   plugins: [
    nextui({
      themes: {
        light: {
          colors: {
            primary: "#FFFFFF",
          }
        },
        dark: {
          colors: {
            primary: "#000000",
          }
        },
      },
    }),
  ],
};

