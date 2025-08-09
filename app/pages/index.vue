<script setup lang="ts">
import animeCard from '~/components/anime-card.vue'
import animeBatch from '~/components/anime-batch.vue'

const config = useAppConfig()
const route = useRoute()
// Search variable
const s = ref(route.query.s)
const post_type = ref(route.query.post_type)

const animeUpdate = ref({
    isLoading: true,
    data: <any>[]
})

const fetchAnime = async () => {
    animeUpdate.value.isLoading = true
    try {
        const res = <any>await $fetch(config.uri + '/anime/update') // Ganti dengan API kamu
        animeUpdate.value.data = res.data
        console.log(res.data);
    } catch (error) {
        console.error('Fetch failed:', error)
    } finally {
        animeUpdate.value.isLoading = false
    }
}

const fetchSearch = async () => {
    animeUpdate.value.isLoading = true
    try {
        const res = <any>await $fetch(config.uri + `/?s=${s.value}&post_type=${post_type.value}`)
        animeUpdate.value.data = res.data
    } catch (error) {
        console.error('Fetch search failed:', error)
    } finally {
        animeUpdate.value.isLoading = false
    }
}

watch(route, (newValue) => {
    s.value = newValue.query.s
    post_type.value = newValue.query.post_type
    getRequestData()
})

function getRequestData() {
    s.value ? fetchSearch() : fetchAnime()
}

onMounted(() => {
    getRequestData()
})
</script>

<template>
    <div v-if="!s" class="grid grid-cols-12 gap-4 pt-4">
        <div class="col-span-12 md:col-span-8">
            <!-- Daftar Anime Terbaru -->
            <div class="gap-2 rounded-md">
                <!-- Header Card -->
                <div class="bg-card text-card-foreground flex flex-col gap-6 border shadow-sm py-0 px-4 rounded-md rounded-b-none md-4 mb-1">
                    <div class="@container/card-header auto-rows-min grid-rows-[auto_auto] gap-1.5 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6 px-0 flex justify-between items-center">
                        <div class="leading-none font-semibold py-2">UPDATE ANIME</div>
                        <a class="" href="/contents?project=true">
                            <span class="inline-flex items-center justify-center rounded-md border px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&>svg]:size-3 gap-1 [&>svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden [a&]:hover:bg-accent [a&]:hover:text-accent-foreground bg-primary text-primary-foreground">View all</span>
                        </a>
                    </div>
                </div>
                <!-- Content -->
                <div class="grid grid-cols-3 sm:grid-cols-3 md:grid-cols-3 lg:grid-cols-5 gap-4">
                    <div v-if="animeUpdate.isLoading" v-for="i in 5" :key="i" class="animate-pulse flex space-x-4">
                        <div class="rounded bg-gray-300 h-16 w-16"></div>
                        <div class="flex-1 space-y-4 py-1">
                            <div class="h-4 bg-gray-300 rounded w-3/4"></div>
                            <div class="h-4 bg-gray-300 rounded w-1/2"></div>
                        </div>
                    </div>
                    <template v-else>
                        <animeCard v-for="anime in animeUpdate.data.update" :key="anime" :anime="anime" />
                    </template>
                </div>
            </div>
            <!-- Tombol Selengkapnya -->
            <div class="col-span-12 flex justify-center mt-4">
                <NuxtLink class=" cursor-pointer" to="/contents">
                    <button class="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive bg-primary text-primary-foreground shadow-xs hover:bg-primary/90 h-9 px-4 py-2 has-[>svg]:px-3">Update lainnya</button>
                </NuxtLink>
            </div>
        </div>
        <div class="col-span-12 md:col-span-4">
            <animeBatch :isloading="animeUpdate.isLoading" :anime="animeUpdate.data.complete" />
        </div>
    </div>
    
    <div v-else>
        <div class="gap-2 rounded-md">
            <!-- Header Card -->
            <div class="bg-card text-card-foreground flex flex-col gap-6 border shadow-sm py-0 px-4 rounded-md rounded-b-none md-4 mb-1">
                <div class="@container/card-header auto-rows-min grid-rows-[auto_auto] gap-1.5 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6 px-0 flex justify-between items-center">
                    <div v-if="!animeUpdate.isLoading" class="leading-none font-semibold py-2">{{ animeUpdate.data.length }} hasil ditemukan</div>
                </div>
            </div>
            <!-- Content -->
            <div class="grid grid-cols-3 sm:grid-cols-3 md:grid-cols-3 lg:grid-cols-5 gap-4">
                <div v-if="animeUpdate.isLoading" v-for="i in 5" :key="i" class="animate-pulse flex space-x-4">
                    <div class="rounded bg-gray-300 h-16 w-16"></div>
                    <div class="flex-1 space-y-4 py-1">
                        <div class="h-4 bg-gray-300 rounded w-3/4"></div>
                        <div class="h-4 bg-gray-300 rounded w-1/2"></div>
                    </div>
                </div>
                <template v-else>
                    <animeCard v-for="anime in animeUpdate.data" :key="anime" :anime="anime" :searchMode="true" />
                </template>
            </div>
        </div>
    </div>
</template>