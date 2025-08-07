<script setup lang="ts">
const route = useRoute()
const episode = route.params.id as string

const config = useAppConfig()

const animeDetail = ref<any>({
    isLoading: true,
    data: null,
})

const loadingMediaStream = ref<number | null>(null)
const mediaPlayer = ref<string>('')

const fetchAnimeEpisode = async () => {
    animeDetail.value.isLoading = true
    try {
        const res = <any>await $fetch(config.uri + '/anime/episode/' + episode) // Ganti dengan API kamu
        animeDetail.value.data = res.data
        mediaPlayer.value = res.data.default_stream || ''
    } catch (error) {
        console.error('Fetch failed:', error)
    } finally {
        animeDetail.value.isLoading = false
    }
}

onMounted(() => {
    fetchAnimeEpisode()
})

const base64ToUint8Array = (base64: string): Uint8Array => {
    const binaryString = atob(base64)
    const len = binaryString.length
    const bytes = new Uint8Array(len)

    for (let i = 0; i < len; i++) {
        bytes[i] = binaryString.charCodeAt(i)
    }

    return bytes
}

async function handleStreamChange(streamCode: string, index: number) {
    try {
        loadingMediaStream.value = index
        const streamData = <any>await $fetch(config.uri + `/stream/${episode}/${streamCode}`)
        mediaPlayer.value = streamData.data || mediaPlayer.value
        loadingMediaStream.value = null
    } catch (error) {
        console.error('Error fetching stream data:', error)
    }
}
</script>

<template>
    <div v-if="animeDetail.data" class="container mx-auto max-w-screen-2xl mb-4 mt-4 px-4 !px-0 min-height-[85vh]">
        <div class="container mx-auto max-w-screen-xl mb-4 sm:px-4">
            <div class="w-full">
                <div class="flex flex-col items-center mt-4 text-center mx-4 sm:mx-0">
                    <p class="text-xl font-bold">
                        {{ animeDetail.data.title }}
                    </p>
                    <p class="text-muted-foreground text-xs mt-2">{{ animeDetail.data.release }}</p>
                </div>

                <div class="max-w-screen-xl w-full py-4 px-4 sm:px-0">
                    <div class="text-card-foreground flex flex-col border shadow-sm p-2 my-2 gap-2 rounded-none mb-2 bg-background">
                        <div class="col-span-1 sm:col-span-1 md:col-span-2 xl:col-span-5 flex justify-center items-center gap-4 flex-wrap">
                            <button
                                class="justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive shadow-xs hover:bg-primary/90 h-8 rounded-md px-3 has-[&gt;svg]:px-2.5 cursor-pointer opacity-100 flex items-center gap-1 text-accent-foreground hover:text-white sm:bg-background bg-primary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" class="lucide lucide-chevron-left h-4 w-4"
                                    aria-hidden="true">
                                    <path d="m15 18-6-6 6-6"></path>
                                </svg>
                                <span class="hidden sm:block">Prev Episode</span>
                            </button>
                            <button class="justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive shadow-xs hover:bg-primary/90 h-8 rounded-md px-3 has-[&gt;svg]:px-2.5 cursor-pointer opacity-100 flex items-center gap-1 text-accent-foreground hover:text-white sm:bg-background bg-primary">
                                <span>See All</span>
                            </button>
                            <button class="justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive shadow-xs hover:bg-primary/90 h-8 rounded-md px-3 has-[&gt;svg]:px-2.5 cursor-pointer opacity-100 flex items-center gap-1 text-accent-foreground hover:text-white sm:bg-background bg-primary" disabled>
                                <span class="hidden sm:block">Next Episode</span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" class="lucide lucide-chevron-right h-4 w-4"
                                    aria-hidden="true">
                                    <path d="m9 18 6-6-6-6"></path>
                                </svg>
                            </button>
                        </div>
                    </div>

                    <div>
                        <div class="bg-card text-card-foreground flex flex-col gap-6 border shadow-sm py-0 px-4 rounded-md rounded-b-none md-4 mb-1">
                            <div class="@container/card-header auto-rows-min grid-rows-[auto_auto] gap-1.5 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6 px-0 flex justify-between items-center">
                                <div class="leading-none font-semibold py-2">MEDIA PLAYER</div>
                            </div>
                        </div>
                        <div class="grid grid-cols-12 gap-4 pt-4">
                            <div class="col-span-12 md:col-span-8">
                                <div class="gap-2 rounded-md relative flex overflow-hidden">
                                    <iframe v-if="mediaPlayer" class="relative z-20 w-full aspect-video rounded-2xl m-0 p-0" :src="mediaPlayer" frameborder="0"
                                    allowfullscreen webkitallowfullscreen mozallowfullscreen></iframe>
                                    <div class="absolute z-10 w-full aspect-video rounded-2xl bg-gray-300 animate-pulse"></div>
                                </div>
                            </div>
                            <div class="col-span-12 md:col-span-4">
                                <div class="bg-card text-card-foreground flex flex-col gap-6 border shadow-sm py-0 px-4 rounded-md rounded-b-none md-4 mb-1">
                                    <div class="@container/card-header auto-rows-min grid-rows-[auto_auto] gap-1.5 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6 px-0 flex justify-between items-center">
                                        <div class="leading-none font-semibold py-2">Choose Server</div>
                                    </div>
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols-2 gap-2" style="max-height: 480px; overflow: auto;">
                                    <div v-for="(item, index) in animeDetail.data.stream" :key="item" class="bg-card text-card-foreground flex flex-col border shadow-sm p-1 gap-2 rounded-md hover:bg-primary hover:text-primary-foreground group cursor-pointer" @click="handleStreamChange(item.streamCode, index)">
                                        <div class="py-2 px-2 flex items-center justify-between">
                                            <div class="text-sm undefined hover:text-primary-foreground flex flex-col">
                                                <span v-if="loadingMediaStream === index" class="text-xs text-muted-foreground">Loading...</span>
                                                <span v-else class="text-xs">{{ item.serverName }}</span>
                                                <!-- <p>{{ item.serverName }}</p> -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
