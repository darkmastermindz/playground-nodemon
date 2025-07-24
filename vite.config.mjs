import { defineConfig } from 'vite';
import { VitePluginNode } from 'vite-plugin-node'
// import { tsconfigPaths } from 'vite-tsconfig-paths';

export default defineConfig({
  plugins: [
    // tsconfigPaths(), 
    ...VitePluginNode({
      adapter: 'express',
      appPath: './src/router.ts',
      exportName: 'viteNodeApp',
      tsCompiler: 'esbuild',
      swcOptions: {
        jsc: {
          parser: {
            syntax: 'typescript',
            decorators: true,
          },
          target: 'ES6',
        },
      },
  })],
  build: {
    outDir: 'dist',
    rollupOptions: {
      input: './src/router.ts',
      output: {
        entryFileNames: 'bundle.js',
      },
    },
    target: 'node16',
    sourcemap: true,
    emptyOutDir: true,
    minify: false,
  },
  resolve: {
    extensions: ['.ts', '.js'],
  },
  server: {
    port: 3001,
    proxy: {
      // Forward /api/pokemon to the external Pokémon API
      '/api/pokemon': {
        target: 'https://pokeapi.co/api/v2',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api\/pokemon/, '/pokemon'),
      },
    },
  },
});
