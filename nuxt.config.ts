// https://nuxt.com/docs/api/configuration/nuxt-config
import tailwindcss from "@tailwindcss/vite"

export default defineNuxtConfig({
  ssr: false,
  compatibilityDate: '2025-07-15',
  devtools: { enabled: false },
  modules: ['@nuxt/image', '@nuxt/ui'],
  css: ['~/assets/css/main.css'],
  vite: {
    plugins: [tailwindcss()]
  },
  app: {
    baseURL: '/',
    head: {
      title: 'Simove',
      htmlAttrs: {
        lang: 'id'
      }
    }
  },
  nitro: {
    preset: 'static'
  }
})