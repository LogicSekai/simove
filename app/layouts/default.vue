<script setup lang="ts">
import Alert from '~/components/alert/alert.vue'
const router = useRouter()

const menuState = ref(false)
const searchQuery = ref<string>('')

function gotoSearch() {
    searchQuery.value ? router.push(`/?s=${searchQuery.value}&post_type=anime`) : router.push('/')
}
</script>

<template>
    <div class="bg-primary top-0 left-0 w-full z-50 shadow-md">
        <div class="container mx-auto max-w-screen-2xl">
            <section class="py-2">
                <div class="container">
                    <nav class="hidden justify-between lg:flex">
                        <div class="flex items-center gap-6">
                            <NuxtLink class="flex items-center gap-2 sm:pl-4 active" to="/">
                                <!-- <img class="max-h-12" alt="Westmanga" src="https://westmanga.me/logo.webp"> -->
                                <span class="min-h-12 flex justify-center items-center text-4xl font-bold text-primary-foreground">OtaoTak</span>
                            </NuxtLink>
                            <div class="flex items-center">
                                <nav aria-label="Main" data-orientation="horizontal" dir="ltr" data-slot="navigation-menu" data-viewport="true" class="group/navigation-menu relative flex max-w-max flex-1 items-center justify-center">
                                    <div style="position: relative;">
                                        <ul data-orientation="horizontal" data-slot="navigation-menu-list" class="group flex flex-1 list-none items-center justify-center gap-1" dir="ltr">
                                            <li class="relative">
                                                <NuxtLink class="bg-primary text-primary-foreground group inline-flex h-10 w-max items-center justify-center rounded-md px-4 py-2 text-sm font-medium transition-colors hover:bg-muted hover:text-accent-foreground active" to="/">Home</NuxtLink>
                                            </li>
                                            <li class="relative">
                                                <NuxtLink class="bg-primary text-primary-foreground group inline-flex h-10 w-max items-center justify-center rounded-md px-4 py-2 text-sm font-medium transition-colors hover:bg-muted hover:text-accent-foreground" to="/anime-list">Anime</NuxtLink>
                                            </li>
                                            <li class="relative">
                                                <NuxtLink class="bg-primary text-primary-foreground group inline-flex h-10 w-max items-center justify-center rounded-md px-4 py-2 text-sm font-medium transition-colors hover:bg-muted hover:text-accent-foreground" to="/anime-list">On-Going</NuxtLink>
                                            </li>
                                            <li class="relative">
                                                <NuxtLink class="bg-primary text-primary-foreground group inline-flex h-10 w-max items-center justify-center rounded-md px-4 py-2 text-sm font-medium transition-colors hover:bg-muted hover:text-accent-foreground" to="/anime-list">Genre</NuxtLink>
                                            </li>
                                            <li class="relative">
                                                <NuxtLink class="bg-primary text-primary-foreground group inline-flex h-10 w-max items-center justify-center rounded-md px-4 py-2 text-sm font-medium transition-colors hover:bg-muted hover:text-accent-foreground" to="/anime-list">Jadwal Tayang</NuxtLink>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="absolute top-full left-0 isolate z-50 flex justify-center"></div>
                                </nav>
                            </div>
                        </div>
                        <div class="flex items-center gap-2 mr-4">
                            <div class="relative w-full max-w-xs flex items-center">
                                <div class="flex items-center mr-2">
                                    <button type="button" role="switch" aria-checked="true" data-state="checked" value="on" data-slot="switch" class="peer data-[state=unchecked]:bg-input focus-visible:border-ring focus-visible:ring-ring/50 dark:data-[state=unchecked]:bg-input/80 inline-flex h-[1.15rem] w-8 shrink-0 items-center rounded-full border border-transparent shadow-xs transition-all outline-none focus-visible:ring-[3px] disabled:cursor-not-allowed disabled:opacity-50 relative bg-gray-200 data-[state=checked]:bg-accent" id="darkTheme">
                                        <span data-state="checked" data-slot="switch-thumb" class="bg-background dark:data-[state=unchecked]:bg-foreground dark:data-[state=checked]:bg-card pointer-events-none size-4 rounded-full ring-0 transition-transform data-[state=checked]:translate-x-[calc(100%-2px)] data-[state=unchecked]:translate-x-0 flex items-center justify-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-moon w-3.5 h-3.5 text-primary-foreground" aria-hidden="true">
                                                <path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"></path>
                                            </svg>
                                        </span>
                                    </button>
                                </div>
                                <input v-model="searchQuery" @keyup.enter="gotoSearch" placeholder="Search..." class="bg-background w-full rounded-md border px-3 py-2 pr-10 text-sm placeholder:text-gray-400 focus:outline-none focus:ring-1" type="text">
                                <span @click="gotoSearch" class="absolute inset-y-0 right-3 flex items-center text-gray-400 cursor-pointer">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-search size-4" aria-hidden="true">
                                        <circle cx="11" cy="11" r="8"></circle>
                                        <path d="m21 21-4.3-4.3"></path>
                                    </svg>
                                </span>
                            </div>
                        </div>
                    </nav>
                    <div class="block lg:hidden">
                        <div class="flex items-center justify-between px-4">
                            <button @click="menuState = true" data-slot="sheet-trigger" class="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [>_svg]:pointer-events-none [>_svg:not([class*='size-'])]:size-4 shrink-0 [>_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive hover:bg-accent hover:text-accent-foreground dark:hover:bg-accent/50 size-9 text-primary-foreground" type="button" aria-haspopup="dialog" aria-expanded="false" aria-controls="radix-«ru»" data-state="closed">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-menu text-primary-foreground" aria-hidden="true">
                                    <line x1="4" x2="20" y1="12" y2="12"></line>
                                    <line x1="4" x2="20" y1="6" y2="6"></line>
                                    <line x1="4" x2="20" y1="18" y2="18"></line>
                                </svg>
                            </button>
                            <div class="relative w-full mx-4">
                                <input v-model="searchQuery" @keyup.enter="gotoSearch" placeholder="Search..." class="bg-background w-full rounded-md border px-3 py-2 pr-10 text-sm placeholder:text-gray-400 focus:outline-none focus:ring-1" type="text">
                                <span @click="gotoSearch" class="absolute inset-y-0 right-3 flex items-center text-gray-400 cursor-pointer">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-search size-4" aria-hidden="true">
                                        <circle cx="11" cy="11" r="8"></circle>
                                        <path d="m21 21-4.3-4.3"></path>
                                    </svg>
                                </span>
                            </div>
                            <div class="flex items-center gap-4">
                                <button type="button" role="switch" aria-checked="true" data-state="checked" value="on" data-slot="switch" class="peer data-[state=unchecked]:bg-input focus-visible:border-ring focus-visible:ring-ring/50 dark:data-[state=unchecked]:bg-input/80 inline-flex h-[1.15rem] w-8 shrink-0 items-center rounded-full border border-transparent shadow-xs transition-all outline-none focus-visible:ring-[3px] disabled:cursor-not-allowed disabled:opacity-50 relative bg-gray-200 data-[state=checked]:bg-card" id="darkTheme">
                                    <span data-state="checked" data-slot="switch-thumb" class="bg-background dark:data-[state=unchecked]:bg-foreground dark:data-[state=checked]:bg-card pointer-events-none size-4 rounded-full ring-0 transition-transform data-[state=checked]:translate-x-[calc(100%-2px)] data-[state=unchecked]:translate-x-0 flex items-center justify-center">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-moon w-3.5 h-3.5 text-primary-foreground" aria-hidden="true">
                                            <path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"></path>
                                        </svg>
                                    </span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <Alert />
    <div class="container mx-auto max-w-screen-2xl mb-4 mt-4 px-4 min-height-[85vh]">
        <slot />
    </div>
    <footer>
        <div class="border-t py-4">
            <p class="text-center text-xs font-medium text-muted-foreground mb-4">All the anime on this website are provides by Otakudesu, please buy the anime if it's available in your city or country.</p>
        </div>
    </footer>

    <div v-if="menuState" role="dialog" class="block lg:hidden bg-background data-[state=open]:animate-in data-[state=closed]:animate-out fixed z-50 flex flex-col gap-4 shadow-lg transition ease-in-out data-[state=closed]:duration-300 data-[state=open]:duration-500 data-[state=closed]:slide-out-to-left data-[state=open]:slide-in-from-left inset-y-0 left-0 h-full w-3/4 border-r sm:max-w-sm overflow-y-auto" tabindex="-1" style="pointer-events: auto;">
        <div class="flex flex-col gap-1.5 p-4">
            <h2 class="text-foreground font-semibold">
                <NuxtLink aria-current="page" class="flex items-center gap-2 active" to="/" data-discover="true">
                    <!-- <img class="max-h-8" alt="Westmanga" src="/assets/logo.webp"> -->
                    <span class="min-h-12 flex justify-center items-center text-4xl font-bold text-primary-foreground">OtaoTak</span>
                </NuxtLink>
            </h2>
        </div>
        <div class="flex flex-col gap-6 p-4">
            <div data-slot="accordion" class="flex w-full flex-col gap-4" data-orientation="vertical">
                <NuxtLink aria-current="page" class="text-md font-semibold active" to="/" data-discover="true">Home</NuxtLink>
                <NuxtLink class="text-md font-semibold" to="/anime-list" data-discover="true">Anime</NuxtLink>
                <NuxtLink class="text-md font-semibold" to="/history" data-discover="true">On-Going</NuxtLink>
                <NuxtLink class="text-md font-semibold" to="/bookmark" data-discover="true">Genre</NuxtLink>
                <NuxtLink class="text-md font-semibold" to="/post/ads" data-discover="true">Jadwal Tayang</NuxtLink>
                <!-- <button data-slot="button" class="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [>_svg]:pointer-events-none [>_svg:not([class*='size-'])]:size-4 shrink-0 [>_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive bg-primary text-primary-foreground shadow-xs hover:bg-primary/90 h-9 px-4 py-2 has-[&gt;svg]:px-3">Login</button> -->
            </div>
        </div>
        <button @click="menuState = false" type="button" class="ring-offset-background focus:ring-ring data-[state=open]:bg-secondary absolute top-4 right-4 rounded-xs opacity-70 transition-opacity hover:opacity-100 focus:ring-2 focus:ring-offset-2 focus:outline-hidden disabled:pointer-events-none">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-x size-4" aria-hidden="true">
                <path d="M18 6 6 18"></path>
                <path d="m6 6 12 12"></path>
            </svg>
            <span class="sr-only">Close</span>
        </button>
    </div>
</template>