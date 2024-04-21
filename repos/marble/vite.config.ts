import { defineConfig } from 'vite'
import solid from 'vite-plugin-solid'
import { resolve } from 'node:path'
export default defineConfig({
  plugins: [solid()],
  build: {
          lib: {
        entry: resolve(__dirname, 'lib/main.ts'),
          formats: ['es']
     }
}
})
