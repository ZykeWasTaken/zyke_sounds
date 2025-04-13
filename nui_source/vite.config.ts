import { defineConfig } from "vite";

// Replace with your actual path to the NUI folder
export default defineConfig({
    build: {
        outDir: "./../nui",
        emptyOutDir: true,
    },
    base: "./", // ensures relative paths
});
