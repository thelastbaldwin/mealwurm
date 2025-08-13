import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import tailwindcss from "@tailwindcss/vite";
import { resolve } from "path";

const envDir = resolve(__dirname, "..");

// https://vite.dev/config/
export default defineConfig({
  plugins: [tailwindcss(), react()],
  envDir,
  server: {
    port: 3000,
  },
});
