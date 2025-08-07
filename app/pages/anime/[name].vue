<script setup lang="ts">
import animeRecomendation from '~/components/anime-recomendation.vue'

const route = useRoute()
const config = useAppConfig()
const id = route.params.name as string

const animeDetail = ref<any>({
    isLoading: true,
    data: {}
})

const stringArray = (value: string | string[]) => {
    if (Array.isArray(value)) {
        // Jika sudah array, pastikan semua elemen sudah di-trim
        return value.map((v) => v.trim())
    } else if (typeof value === 'string') {
        // Jika string, split dengan koma dan trim
        return value.split(',').map((genre) => genre.trim())
    }
    return []
}


const fetchAnimeDetail = async () => {
    animeDetail.value.isLoading = true
    try {
        const res = <any>await $fetch(config.uri + '/anime/detail/' + id) // Ganti dengan API kamu
        animeDetail.value.data = res.data
    } catch (error) {
        console.error('Fetch failed:', error)
    } finally {
        animeDetail.value.isLoading = false
    }
}

onMounted(() => {
    fetchAnimeDetail()
})
</script>

<template>
    <div class="grid grid-cols-12 gap-4 pt-4">
        <div class="col-span-12 md:col-span-8">
            <!-- Anime Information -->
            <div class="gap-2 rounded-md">
                <div class="@container/card-header grid auto-rows-min grid-rows-[auto_auto] gap-1.5 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6 px-0 justify-between items-center">
                    <div class="leading-none font-semibold break-words">{{ animeDetail.data.detail?.title }}</div>
                </div>
                <div class="p-0">
                    <div class="grid grid-cols-12 gap-4 pt-4">
                        <div class="col-span-12 md:col-span-3 flex flex-col items-center justify-top">
                            <div class="relative">
                                <div class="relative inline-block">
                                    <div v-if="!animeDetail.data.detail" class="rounded-md bg-gray-300 animate-pulse w-[250px] h-[337.500px]"></div>
                                    <img v-else class="rounded-md object-fill w-full w-[250px] h-[337.500px] mx-auto" :src="config.uri + animeDetail.data.detail?.img" style="aspect-ratio: 1 / 1.5;">
                                </div>
                            </div>
                            <button class="whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive bg-primary text-primary-foreground shadow-xs hover:bg-primary/90 h-9 px-4 py-2 has-[>svg]:px-3 w-full flex items-center justify-center gap-2 mt-4 max-w-[250px]">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-bookmark h-4 w-4 mr-2" aria-hidden="true">
                                    <path d="m19 21-7-4-7 4V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16z"></path>
                                </svg> Add Bookmark
                            </button>
                        </div>
                        <div class="col-span-12 md:col-span-9">
                            <div v-if="!animeDetail.data.detail" class="text-muted-foreground break-words w-full h-32 animate-pulse bg-gray-300 rounded-md"></div>
                            <div v-else class="text-muted-foreground break-words" v-html="animeDetail.data.detail?.synopsis"></div>
                            <div class="relative w-full overflow-x-auto">
                                <table class="w-full caption-bottom text-sm mt-4 border-collapse border">
                                    <tbody class="[&_tr:last-child]:border-0">
                                        <template v-if="!animeDetail.data.detail">
                                            <tr v-for="i in 10" class="animate-pulse hover:bg-muted/50 data-[state=selected]:bg-muted border-b transition-colors">
                                                <td class="p-2 align-middle whitespace-nowrap [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px] font-bold text-xs text-muted-foreground pr-2 border-r">
                                                    <div class="w-10 h-2 bg-gray-300 rounded"></div>
                                                </td>
                                                <td class="p-2 align-middle whitespace-nowrap [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px] text-xs text-muted-foreground">
                                                    <div class="w-20 h-2 bg-gray-300 rounded"></div>
                                                </td>
                                            </tr>
                                        </template>
                                        <template v-else v-for="(item, index) in animeDetail.data.detail.info" :key="index">
                                            <tr v-if="index !== animeDetail.data.detail.info.length - 1" class="hover:bg-muted/50 data-[state=selected]:bg-muted border-b transition-colors">
                                                <td class="p-2 align-middle whitespace-nowrap [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px] font-bold text-xs text-muted-foreground pr-2 border-r">{{ item.properti }}:</td>
                                                <td class="p-2 align-middle whitespace-nowrap [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px] text-xs text-muted-foreground"> {{ item.value }}</td>
                                            </tr>
                                        </template>
                                    </tbody>
                                </table>
                            </div>
                            <!-- genre -->
                            <div class="flex flex-wrap gap-1 mt-4">
                                <template v-if="!animeDetail.data.detail">
                                    <div class="flex flex-wrap gap-1 mt-1">
                                        <span class="bg-gray-300 animate-pulse rounded-md w-14 h-5 inline-flex items-center justify-center"></span>
                                        <span class="bg-gray-300 animate-pulse rounded-md w-14 h-5 inline-flex items-center justify-center"></span>
                                        <span class="bg-gray-300 animate-pulse rounded-md w-14 h-5 inline-flex items-center justify-center"></span>
                                    </div>
                                </template>
                                <template v-else>
                                    <NuxtLink v-for="item in stringArray(animeDetail.data.detail.info[animeDetail.data.detail.info.length - 1].value)" :to="'/genres/' + item">
                                        <span class="inline-flex items-center justify-center rounded-md border px-2 py-0.5 font-medium w-fit whitespace-nowrap shrink-0 [&>svg]:size-3 gap-1 [&>svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden border-transparent bg-primary text-primary-foreground [a&]:hover:bg-primary/90 text-xs">{{ item }}</span>
                                    </NuxtLink>
                                </template>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Episode -->
            <div v-if="animeDetail.data.detail" class="mt-4 gap-2 rounded-md mt-2">
                <div class="bg-card text-card-foreground flex flex-col gap-6 border shadow-sm py-0 px-4 rounded-md rounded-b-none md-4 mb-1">
                    <div class="@container/card-header auto-rows-min grid-rows-[auto_auto] gap-1.5 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6 px-0 flex justify-between items-center">
                        <div class="leading-none font-semibold py-2">Daftar Episode</div>
                    </div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols-2 gap-2" style="max-height: 480px; overflow: auto;">
                    <div v-for="(item, index) in animeDetail.data.episodes" :key="index"
                    class="bg-card text-card-foreground flex flex-col border shadow-sm p-1 gap-2 rounded-md hover:bg-primary hover:text-primary-foreground group">
                        <div class="p-0 px-2 flex items-center justify-between">
                            <NuxtLink class="text-sm undefined hover:text-primary-foreground flex flex-col" :to="item.link">
                                <p>{{ item.title }} <span v-if="index === 0" class="text-[10px] text-red-600">New</span></p>
                                <p class="text-xs text-muted-foreground">{{ item.date }}</p>
                            </NuxtLink>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Batch -->
            <div v-if="animeDetail.data.batch?.title" class="mt-4 gap-2 rounded-md mt-2">
                <div class="bg-card text-card-foreground flex flex-col gap-6 border shadow-sm py-0 px-4 rounded-md rounded-b-none md-4 mb-1">
                    <div class="@container/card-header auto-rows-min grid-rows-[auto_auto] gap-1.5 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6 px-0 flex justify-between items-center">
                        <div class="leading-none font-semibold py-2">Unduh Batch</div>
                    </div>
                </div>
                <div class="grid grid-cols-1 gap-2" style="max-height: 480px; overflow: auto;">
                    <div class="bg-card text-card-foreground flex flex-col border shadow-sm p-1 gap-2 rounded-md hover:bg-primary hover:text-primary-foreground group">
                        <div class="p-0 px-2 flex items-center justify-between">
                            <NuxtLink class="text-sm undefined hover:text-primary-foreground flex flex-col" :to="animeDetail.data.batch.link">
                                <p>{{ animeDetail.data.batch.title }}</p>
                                <p class="text-xs text-muted-foreground">{{ animeDetail.data.batch.date }}</p>
                            </NuxtLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-span-12 md:col-span-4">
            <animeRecomendation :isloading="animeDetail.isLoading" :anime="animeDetail.data.recommendation" />
        </div>
    </div>
</template>